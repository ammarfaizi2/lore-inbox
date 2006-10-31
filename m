Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423529AbWJaR50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423529AbWJaR50 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423715AbWJaR50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:57:26 -0500
Received: from rtr.ca ([64.26.128.89]:47372 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1423529AbWJaR5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:57:25 -0500
Message-ID: <45478E82.3030808@rtr.ca>
Date: Tue, 31 Oct 2006 12:57:22 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>, Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: 2.6.19-rc3-git7:  BUG: mutex warning sysfs_dir_open
References: <454785B7.3040600@rtr.ca> <Pine.LNX.4.64.0610310929090.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610310929090.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Is this somewhat reproducible? 

Just the one occurance of it, with rc3-git7.
I've now moved on to -rc4.

> HOWEVER, google does find a clue. We've had reports of something somewhat 
> similar before: googling for "__mutex_lock_slowpath" and "sysfs_dir_open" 
> shows for example
> 
> 	http://lkml.org/lkml/2006/8/18/72
> 
> where the thread ended up first blaming sound, but then deciding that 
> maybe it was DRM-related. However, you don't seem to have any AGP or DRM 
> support at all, so maybe it really _is_ a sound problem.
> 
> Mark - can you verify that you don't have any DRM support in your kernel?

# CONFIG_DRM is not set

(but I'm about to change that!).

Cheers
