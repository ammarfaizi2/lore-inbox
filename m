Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264068AbRFESOs>; Tue, 5 Jun 2001 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbRFESOi>; Tue, 5 Jun 2001 14:14:38 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:5126 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S264077AbRFESO0>; Tue, 5 Jun 2001 14:14:26 -0400
Date: Tue, 05 Jun 2001 14:13:54 -0400
From: Chris Mason <mason@suse.com>
To: Carlos E Gorges <carlos@techlinux.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 245ac7 - ncr53c8xx && reiserfs
Message-ID: <972450000.991764834@tiny>
In-Reply-To: <01060514511100.00321@shark.techlinux>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, June 05, 2001 03:00:40 PM -0400 Carlos E Gorges
<carlos@techlinux.com.br> wrote:

> Hi all,
> 
> I get some problems w/ 2.4.5-ac7, ncr53c8xx w/ 2.4.4-ac18 works fine.
> 
> I gave a small looked on problem  ..
> the problem apparently is w/ ncr53c8xx driver ( who accuses timeout ),
> and make reiserfs call BUG() :
> 

reiserfs does this when it fails to write metadata or log buffers,
continuing without a panic or readonly mount will result in FS corruption.  

A forced readonly mount is a much better solution, but I haven't had a
chance yet to make sure it safely prevents writeback of all metadata, and
cleans things up properly.

-chris


