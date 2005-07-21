Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVGUFXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVGUFXV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVGUFXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:23:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4298 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261626AbVGUFWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:22:30 -0400
Date: Thu, 21 Jul 2005 07:22:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Hiroyuki Machida <machida@sm.sony.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] FAT robustness
Message-ID: <20050721052231.GA7835@elf.ucw.cz>
References: <42D9FDAC.3010109@sm.sony.co.jp> <42DB9911.9010106@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DB9911.9010106@grupopie.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >[...]
> > Q3 : I'm not sure JBD can be used for FAT improvements.       Do you 
> >have any comments ?
> 
> I might not be the best person to answer this, but this just seems so 
> obvious:
> 
> If you plan to let a recently hot-unplugged device to be used in another 
> OS that doesn't understand your journaling extensions, your disk will be 
> corrupted.

It will only be corrupted if you unplug it without unmounting, and it
will only be corrupted as much as non-journalling disk is. Plus, you
might intentionaly damage superblock signature on mount (an fix it on
clean umount) so that you force user to plug it back to journalling
system....
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
