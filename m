Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTL2AFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 19:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTL2AFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 19:05:16 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:13538 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262882AbTL2AFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 19:05:12 -0500
Date: Sun, 28 Dec 2003 16:05:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: lkml@dhtns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: JFS resize=0 problem in 2.6.0
Message-ID: <20031229000503.GD1882@matchmail.com>
Mail-Followup-To: lkml@dhtns.com, linux-kernel@vger.kernel.org
References: <20031228153028.GB22247@faraday.dhtns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228153028.GB22247@faraday.dhtns.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 10:30:28AM -0500, lkml@dhtns.com wrote:
> It seems to me that line 264 is attempting to test for the mount 
> paramater "resize=0", and when it comes across this, resize to the full
> size of the volume.  However, this doesn't work.  I believe it should
> test for the char '0'  (*resize=='0'), not against literal zero.  
> 
> Let me know if I'm way off base here.  But the below patch does allow a
> $ mount -o remount,resize=0 /mnt/test    
> to resize the jfs filesystem to the full size of the volume.

And it won't without the patch?

What errors do you get if it fails without the patch?
