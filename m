Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRBTVEB>; Tue, 20 Feb 2001 16:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129791AbRBTVDv>; Tue, 20 Feb 2001 16:03:51 -0500
Received: from ns2.cypress.com ([157.95.67.5]:13552 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S129282AbRBTVDj>;
	Tue, 20 Feb 2001 16:03:39 -0500
Message-ID: <3A92DB9F.28DF79F1@cypress.com>
Date: Tue, 20 Feb 2001 15:03:27 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel/printk.c: increasing the buffer size to capture 
 devfsd debug messages.
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp> <20010220111542.A4106@tenchi.datarithm.net> <3A92C76C.6519DF1A@cypress.com> <20010220121727.B4106@tenchi.datarithm.net> <3A92D930.6F11B505@cypress.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dodd wrote:
> 
> Robert Read wrote:
> >
> > Ok, here is a simple patch to add a config option, I'm compiling it
> > now, so it's not tested yet.  One question: what is the best way to
> > force this option to be a power of 2?
> 
> Why not just make the config option in Kbytes.
> and do:
> 
> #define LOG_BUF_LEN (CONFIG_PRINTK_BUF_LEN * 1024)
> 
> since the config option has a default option and will
> always be defined, is the #ifdef check really needed?

Oops...

It's not needed if all arch's have the config option added.
Only parisc uses a different file, config.common instead of config.in
Would this break any thing?

	-Thomas
