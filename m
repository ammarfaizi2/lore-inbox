Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVAaW3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVAaW3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVAaW3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:29:05 -0500
Received: from sd291.sivit.org ([194.146.225.122]:27308 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261401AbVAaW15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:27:57 -0500
Date: Mon, 31 Jan 2005 23:27:54 +0100
From: Stelian Pop <stelian@popies.net>
To: dtor_core@ameritech.net
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/char/sonypi.c: make 3 structs static
Message-ID: <20050131222753.GG28886@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	dtor_core@ameritech.net, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050131173508.GS18316@stusta.de> <20050131214905.GF28886@deep-space-9.dsnet> <d120d500050131141358ff63c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050131141358ff63c9@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 05:13:22PM -0500, Dmitry Torokhov wrote:

> On Mon, 31 Jan 2005 22:49:05 +0100, Stelian Pop <stelian@popies.net> wrote:
> > 
> > sonypi.h is a "local" header file used only by sonypi.c.
> > 
> > I would like to keep those tables in sonypi.h rather than putting
> > all into sonypi.c (or we could as well remove sonypi.h and put all the
> > contents into the .c).
> > 
> 
> Hi,
> 
> What is the point of having an .h file if it is not used by anyone?
> Judging by the fact that it completely protected by #ifdef __KERNEL__
> there should be no userspace clients either.
> 
> I always thought that the only time .h is needed is when you define
> interface to your code. I'd fold it to sonpypi.c.

It isn't strictly *needed*, but it does separate a bit the data
structures and the constants (in the .h) from the code (in the .c).

Stelian.
-- 
Stelian Pop <stelian@popies.net>
