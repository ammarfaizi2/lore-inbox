Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316764AbSEUXCB>; Tue, 21 May 2002 19:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSEUXCA>; Tue, 21 May 2002 19:02:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316764AbSEUXB7> convert rfc822-to-8bit; Tue, 21 May 2002 19:01:59 -0400
Date: Tue, 21 May 2002 16:01:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g4LN1aj03125
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Pavel Machek wrote:
> 
> Major parts are: process stopper, S3 specific code, S4 specific
> code. What can I do to make this applied?

Applied. Nothing needed but some time for me to look through it.

It still has a few too many #ifdef CONFIG_SUSPEND, and I get this feeling 
that the background deamons shouldn't need to do the "freeze()" by hand 
but simply be automatically frozen and thawed when they sleep by looking 
at the KERNTHREAD bit or something, but..

		Linus


