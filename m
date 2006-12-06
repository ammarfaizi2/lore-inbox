Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759349AbWLFBIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759349AbWLFBIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759385AbWLFBIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:08:16 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:39819 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759349AbWLFBIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:08:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:subject:message-id:mime-version:content-type:con
	tent-disposition:in-reply-to:user-agent;
	b=bumIW/58Wldauta0RtmqFvuu4d2TovRZlUKrFUp1Hoj13yJftfLsbyOUN0MaU
	N2l+1I7rENvYbfbKKfXATauBg==
Date: Wed, 6 Dec 2006 02:08:13 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       linux-arm-toolchain@lists.arm.linux.org.uk,
       linux-arm-kernel@lists.arm.linux.org.uk, crossgcc@sourceware.org
Subject: Re: More ARM binutils fuckage
Message-ID: <20061206010813.GC30401@xi.wantstofly.org>
References: <20061205193357.GF24038@flint.arm.linux.org.uk> <f2b55d220612051529t3c0dcda8ma920c13b00899b10@mail.gmail.com> <20061206002226.GK24038@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206002226.GK24038@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 12:22:26AM +0000, Russell King wrote:

> Enabling EABI needs a compiler which supports EABI.  That's where I
> get fuzzy but recent gcc 4 should be suitable.  I have had it suggested
> to me that EABI support in the toolchain isn't all that stable at the
> moment.

I use a bog-standard gcc 4.1.0 to cross-compile all my ARM kernels
with, which allows me to build both old-ABI and EABI kernels.  (These
days I build all kernels in EABI mode with old-ABI compat.)  I have
not run into any code generation issues with this compiler yet.

On the ARM I am running an EABI userland with glibc 2.5, and build
stuff natively with vanilla binutils 2.17.50.0.5 (2.17.5.0.3 is 'too
old', as it doesn't understand the two argument form of the .movsp
directive which one of the gcc ICE fix patches emits), and gcc 4.1.1
with some patches from gcc bugzilla to fix an ICE or two.
