Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130169AbRBTUxv>; Tue, 20 Feb 2001 15:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130030AbRBTUxc>; Tue, 20 Feb 2001 15:53:32 -0500
Received: from ns2.cypress.com ([157.95.67.5]:41966 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S130169AbRBTUxS>;
	Tue, 20 Feb 2001 15:53:18 -0500
Message-ID: <3A92D930.6F11B505@cypress.com>
Date: Tue, 20 Feb 2001 14:53:04 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: kernel/printk.c: increasing the buffer size to capture 
 devfsd debug messages.
In-Reply-To: <3A92A99E.2F255CB3@yk.rim.or.jp> <20010220111542.A4106@tenchi.datarithm.net> <3A92C76C.6519DF1A@cypress.com> <20010220121727.B4106@tenchi.datarithm.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Read wrote:
> 
> On Tue, Feb 20, 2001 at 01:37:16PM -0600, Thomas Dodd wrote:
> > Robert Read wrote:
> > >
> > > On Wed, Feb 21, 2001 at 02:30:08AM +0900, Ishikawa wrote:
> > > >
> > > > Has anyone tried 128K buffer size in kernel/printk.c
> > > > and still have the kernel boot (without
> > > > hard to notice memory corruption problems  and other subtle bugs)?
> > > > Any hints and tips will be appreciated.
> > >
> > > I have used 128k and larger buffer sizes, and I just noticed this
> > > fragment in the RedHat Tux Webserver patch.  It creates a 2MB buffer:
> >
> > I think this should be a config option.
> 
> Ok, here is a simple patch to add a config option, I'm compiling it
> now, so it's not tested yet.  One question: what is the best way to
> force this option to be a power of 2?

Why not just make the config option in Kbytes.
and do:

#define LOG_BUF_LEN (CONFIG_PRINTK_BUF_LEN * 1024)

since the config option has a default option and will
always be defined, is the #ifdef check really needed?

	-Thomas
