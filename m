Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269307AbRGaOLw>; Tue, 31 Jul 2001 10:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269304AbRGaOLl>; Tue, 31 Jul 2001 10:11:41 -0400
Received: from mail.zmailer.org ([194.252.70.162]:34564 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269303AbRGaOLb>;
	Tue, 31 Jul 2001 10:11:31 -0400
Date: Tue, 31 Jul 2001 17:11:29 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Gareth Hughes <gareth.hughes@acm.org>
Cc: paulr <reichp@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 -- GCC-3.0 -- "multiline string literals deprecated" -- PATCH
Message-ID: <20010731171129.U2650@mea-ext.zmailer.org>
In-Reply-To: <3B663AC9.3A290C32@ameritech.net> <3B66B838.C8B427B1@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B66B838.C8B427B1@acm.org>; from gareth.hughes@acm.org on Tue, Jul 31, 2001 at 11:52:56PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 11:52:56PM +1000, Gareth Hughes wrote:
> paulr wrote:
> > Folks,
> > 
> > While building both kernels 2.4.6 and 2.4.7,
> > I encountered a series of compiler warnings,
> > 
> > warning: multiline string literals are deprecated.
> > 
> > The build environment was gcc3.0 and binutils-2.11.2.
> 
> Yes, unfortunately GCC 3.0 deprecated multiline string literals -- I saw
> someone arguing on the GCC mailing lists that writing large chunks of
> inline asm shouldn't be "easy",....

   Those are different things.

   The multiline string literal deprecation comes from people who
   define what the new ANSI-C (C9X, or whatever) is, and inline asm
   just uses literal strings as its input data.

   The inline asm() does essentially want to look like a function call
   with lots of strings as parameters.  It has special __builtin_ meaning,
   of course, but that is way after the lexical input scanner has done
   its work.

> -- Gareth

/Matti Aarnio
