Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUF0TRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUF0TRN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUF0TRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:17:13 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:36364 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S261685AbUF0TRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:17:10 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Sun, 27 Jun 2004 21:16:34 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Kronos <kronos@kronoz.cjb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb: cannot map FB
In-Reply-To: <20040626224942.GA13345@dreamland.darkstar.lan>
Message-ID: <Pine.OSF.4.51.0406272113190.111358@tao.natur.cuni.cz>
References: <20040626224942.GA13345@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  yes, I have one GB and SMP kernel. It's interresting that I don't
remember this bug with kernels around 2.4.23 or .24 - just a guess. If
someone would be interrwested, and can check when did it appear for the
first time. Otherwise, will be happy to get your patch. I think the
printk() lines could print out more debug info. For example the contents of
some variables which were passed to preceeding functions ... ;)
Martin

On Sun, 27 Jun 2004, Kronos wrote:

> Martin MOKREJ? <mmokrejs@natur.cuni.cz> ha scritto:
> > Hi,
> >  could someone help with radeonfb not detected under 2.4.27-rc2?
> > I filed this bug under the 2.6 bugzilla ... :(
> > http://bugzilla.kernel.org/show_bug.cgi?id=2917
> > Thanks
> > Please Cc: me in replies.
>
> ioremap is failing. You likely have 1GB (or more) of RAM and kernel is
> unable to find some space in lowmem to map the video RAM (128MB).
>
> In 2.6 this is fixed by mapping only a small amount of video RAM (at
> most 16MB).
>
> Backport should be easy, I'll cook a patch ASAP.
>
> Luca
>

-- 
Martin Mokrejs
GPG key is at http://www.natur.cuni.cz/~mmokrejs
