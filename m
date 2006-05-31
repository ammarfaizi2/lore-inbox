Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWEaHZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEaHZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 03:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWEaHZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 03:25:20 -0400
Received: from smtp.enter.net ([216.193.128.24]:14858 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964826AbWEaHZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 03:25:19 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Wed, 31 May 2006 03:25:09 +0000
User-Agent: KMail/1.8.1
Cc: "Martin Mares" <mj@ucw.cz>, "Ondrej Zajicek" <santiago@mail.cz>,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <mj+md-20060531.064701.10737.atrey@ucw.cz> <9e4733910605310013y22dfa6cah766047957ad2a3c0@mail.gmail.com>
In-Reply-To: <9e4733910605310013y22dfa6cah766047957ad2a3c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605310325.10030.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 May 2006 07:13, Jon Smirl wrote:
> On 5/31/06, Martin Mares <mj@ucw.cz> wrote:
> > > My thoughts are mixed on continuing to support text mode for anything
> > > other than initial boot/install. Linux is all about multiple languages
> > > and the character ROMs for text mode don't support all of these
> > > languages.
> >
> > On most servers, you don't need (and you don't want) anything like that.
> > In such cases, everything should be kept simple.
>
> Not so simple if you only speak Chinese and are installing that server.

In cases such as that there is more needed than just having the display 
showing the language in it's proper characters, be that zhongwen for the 
Chinese, Katakana for the Japanese or Cyrillic for the Russians.

In the case of Oriental languages the system also needs to understand the 
keyboard and it's input method. Research I have done for a project not 
related to the kernel (or programming) has led me to the fact that the most 
common Chinese system uses a combination of several keystrokes to generate 
each character. The other systems rely on a "smart" system to translate 
pinyin or related systems of writing chinese in roman characters into 
zhongwen.

That being the case, the kernel would then be best served by also 
understanding this input method. The work I am currently doing should enable 
the console to display any true-type font, not just the ones currently 
allowed, though vgacon and the fbdev drivers will still have the current 
limitation.

DRH
