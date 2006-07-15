Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWGOFWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWGOFWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 01:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWGOFWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 01:22:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932429AbWGOFWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 01:22:19 -0400
Date: Fri, 14 Jul 2006 22:21:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, stable@kernel.org,
       Marcel Holtmann <holtmann@redhat.com>
Subject: Re: Linux 2.6.17.5
In-Reply-To: <20060715030047.GC11167@kroah.com>
Message-ID: <Pine.LNX.4.64.0607142217020.5623@g5.osdl.org>
References: <20060715030047.GC11167@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Greg KH wrote:
> 
> I'll also be replying to this message with a copy of the patch between
> 2.6.17.4 and 2.6.17.5, as it is small enough to do so.

I did a slight modification of the patch I committed initially, in the 
face of the report from Marcel that the initial sledge-hammer approach 
broke his hald setup.

See commit 9ee8ab9fbf21e6b87ad227cd46c0a4be41ab749b: "Relax /proc fix a 
bit", which should still fix the bug (can somebody verify? I'm 100% sure, 
but still..), but is pretty much guaranteed to not have any secondary side 
effects.

It still leaves the whole issue of whether /proc should honor chmod AT ALL 
open, and I'd love to close that one, but from a "minimal fix" standpoint, 
I think it's a reasonable (and simple) patch.

Marcel, can you check current git?

		Linus
