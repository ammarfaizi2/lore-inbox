Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVCWWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVCWWid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVCWWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:37:17 -0500
Received: from simba.math.ucla.edu ([128.97.4.125]:61313 "EHLO
	simba.math.ucla.edu") by vger.kernel.org with ESMTP id S262109AbVCWWea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:34:30 -0500
Date: Wed, 23 Mar 2005 14:34:27 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disc driver is module, software suspend fails
In-Reply-To: <20050323101706.GB1407@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0503231431100.15146@simba.math.ucla.edu>
References: <Pine.LNX.4.61.0503222212210.7671@xena.cft.ca.us>
 <20050323101706.GB1407@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Pavel Machek wrote:

> > I put some printk's into 2.6.11.5 and found out the reason for this
> > behavior: in kernel/power/swsusp.c, static resume_device == 0.  The
> > reason it's 0 is that swsusp_read uses name_to_dev_t to interpret
> > resume=/dev/sda5, a bogus block device name.  The reason it's bogus
> > is
> ...
> This is WONTFIX for 2.6.11, but you can be pretty sure it is going to
> be fixed for SuSE 9.3, and patch is already in 2.6.12-rc1. Feel free
> to betatest SuSE 9.3 ;-).

Many thanks!  Definitely I'll beta-test SuSE 9.3, and download 2.6.12-rc1 
for a self-compiled kernel.  SuSE rocks; open source rocks!

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
