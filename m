Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTIHNZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbTIHNYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50653 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262265AbTIHNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:03 -0400
Date: Wed, 3 Sep 2003 14:50:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, jim.houston@comcast.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030903125019.GN1358@openzaurus.ucw.cz>
References: <1061498486.3072.308.camel@new.localdomain> <16197.14968.235907.128727@gargle.gargle.HOWL> <20030825060900.GA21213@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825060900.GA21213@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I double-checked AP-485 (24161823.pdf, the "real" reference to CPUID),
> > and it says (section 3.4) that SEP is unsupported when the signature
> > as a whole is less that 0x633. This means all PPros, and PII Model 3s
> > with steppings less than 3.
> 
> "SEP is unsupported".  It's interesting that Pentium Pro erratum #82
> is "SYSENTER/SYSEXIT instructions can implicitly load 'null segment
> selector' to SS and CS registers", implying that SYSENTER does
> _something_ useful on PPros.

Well, with CS==0 machine is not going to survive too long.
If it only happens sometimes you might catch the double fault
and fixup, but....
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

