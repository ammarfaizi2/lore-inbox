Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTKRRsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 12:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTKRRsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 12:48:31 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:14733 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S263745AbTKRRsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 12:48:30 -0500
Date: Tue, 18 Nov 2003 17:48:28 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: Patrick Beard <patrick@scotcomms.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Smartmedia 2.6.0-test9 problem.
Message-ID: <20031118174828.GA26450@axis.demon.co.uk>
References: <bpcumv$v22$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bpcumv$v22$1@sea.gmane.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 11:11:26AM -0000, Patrick Beard wrote:
> I have two smartmedia cards 16mb and 64mb. I have recently compiled
> the Debian source for Kernel 2.6.0-test9.  I normally only use my
> 64mb card together with a usb reader. The problem I have led me to
> the wrong conclusion which I reported to this group. For this I
> apologise.

I wonder if you are seeing the same thing I see...

I have several different sized memory cards which I use using a usb
adaptor.  The kernel (I've only tried 2.4 not 2.6) recognises the
first one fine, but refuses to update its internal knowledge of the
size of the card so if I insert a different sized one it doesn't mount
properly.

The work-around I use is to "rmmod usb-storage ; modprobe usb-storage"
whenever I change memory card - this kicks the kernel into re-reading
the size of the media (or maybe the partition table) and it all works
fine after that.

This obviously isn't ideal but I haven't found a better solution.

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
