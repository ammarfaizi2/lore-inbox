Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269596AbRHACHd>; Tue, 31 Jul 2001 22:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269597AbRHACHW>; Tue, 31 Jul 2001 22:07:22 -0400
Received: from roc-24-95-218-9.rochester.rr.com ([24.95.218.9]:4612 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S269596AbRHACHM>; Tue, 31 Jul 2001 22:07:12 -0400
Date: Tue, 31 Jul 2001 22:05:41 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
Message-ID: <41340000.996631541@tiny>
In-Reply-To: <01080103011705.00303@starship>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Wednesday, August 01, 2001 03:01:17 AM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

> Hi, Chris
> 
> On Tuesday 31 July 2001 21:07, Chris Mason wrote:
>> I had to keep some of the flush_dirty_buffer calls as page_launder
>> wasn't triggering enough i/o on its own.  What I'd like to do now is
>> experiment with changing bdflush to only write pages off the inactive
>> dirty lists.
> 
> Will kupdate continue to enforce the "no dirty buffer older than 
> XX" guarantee?

Yes, kupdate still calls flush_dirty_buffers(1).  I'm curious to see how
your write early stuff interacts with it all though....

-chris


