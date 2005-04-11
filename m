Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVDKLAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVDKLAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDKLAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:00:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16109 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261772AbVDKLAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:00:48 -0400
Date: Mon, 11 Apr 2005 13:00:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Oops in swsusp
Message-ID: <20050411110023.GC1373@elf.ucw.cz>
References: <4259B425.4090105@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4259B425.4090105@domdv.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> during testing of the encrypted swsusp_image on x86_64 I did get an Oops
> from time to time at memcpy+11 called from swsusp_save+1090 which turns
> out to be the memcpy in copy_data_pages() of swsusp.c.
> The Oops is caused by a NULL pointer (I don't remember if it was source
> or destination).
> This Oops seems to be unrelated to the encrypted image addition as I
> didn't touch any code in that area.

Could you still try to reproduce without any patches? Alocating memory
at wrong moment may cause something like that, and crypto routines
might do that.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
