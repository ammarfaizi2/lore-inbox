Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTIKIpe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbTIKIpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:45:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:51216 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261169AbTIKIpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:45:32 -0400
Date: Thu, 11 Sep 2003 10:38:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
In-Reply-To: <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.44.0309111037050.19512-100000@serv>
References: <20030910155542.GD4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910170610.GH27368@fs.tum.de> <20030910185902.GE4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910191038.GK27368@fs.tum.de> <20030910193158.GF4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910195544.GL27368@fs.tum.de> <20030910210443.GG4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910215136.GP27368@fs.tum.de> <20030910220552.GJ4559@ip68-0-152-218.tc.ph.cox.net>
 <20030910221710.GT27368@fs.tum.de> <20030910222918.GL4559@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Sep 2003, Tom Rini wrote:

> > Let me paraphrase the dependency the other way round (I'm not sure 
> > whether the syntax is 100% correct):
> > 
> > config KEYBOARD_ATKBD
> > 	tristate "AT keyboard support" if EMBEDDED || !X86 
> > 	default y
> > 	depends on INPUT_KEYBOARD
> > 	select SERIO=m
> > 	select SERIO=y if KEYBOARD_ATKBD=y
> > 	help
> > 	  ...
> 
> Ah yes.
> 
> This is similar (the same, even?) to the test3 problem.  Roman, can we
> get select to somehow pay attention to depend as well?  I do believe
> it's possible to have A select B, have C depend on Z and end up with:
> A=y
> B=y
> C=n

Could you give me a complete example, I don't understand yet, what it's 
exactly supposed to do.

bye, Roman

