Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbTHRMJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271412AbTHRMJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:09:21 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:5605 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S271407AbTHRMJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:09:05 -0400
Date: Mon, 18 Aug 2003 14:08:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, thunder7@xs4all.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030818120848.GB861@elf.ucw.cz>
References: <20030813045638.GA9713@middle.of.nowhere> <20030813014746.412660ae.akpm@osdl.org> <20030813091958.GA30746@gates.of.nowhere> <20030813025542.32429718.akpm@osdl.org> <1060772769.8009.4.camel@localhost.localdomain> <20030813042544.5064b3f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813042544.5064b3f4.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Put the likely(pos) in the asm/prefetch for Athlon until someone can
> >  figure out what is going on with some specific Athlons, 2.6 and certain
> >  kernels (notably 4G/4G).
> 
> <riffles through random config options>
> 
> Like this?

> What happens if someone runs a K6 kernel on a K7?

You break things :-(.

Also prefetch with test for null does probably more harm than
good. What about simply assuming K7 can not do prefetch?

							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
