Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbTAQSuw>; Fri, 17 Jan 2003 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTAQSuv>; Fri, 17 Jan 2003 13:50:51 -0500
Received: from havoc.daloft.com ([64.213.145.173]:16784 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267639AbTAQSuv>;
	Fri, 17 Jan 2003 13:50:51 -0500
Date: Fri, 17 Jan 2003 13:59:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "Brian M. Hunt" <bmh@q1labs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SOUND_ICH=m does not compile ac97_audio
Message-ID: <20030117185945.GC8304@gtf.org>
References: <1042829674.966.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042829674.966.15.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 02:54:34PM -0400, Brian M. Hunt wrote:
> Compiling Linux Kernel 2.4.20
> CONFIG_SOUND_ICH=m does not compile ac97_codec.o, which it depends upon.
> 
> CONFIG_SOUND_ICH is described as 'Intel ICH (i8xx), SiS 7012, NVidia
> nForce Audio or AMD 768/811x'
> 
> It is listed in drivers/sound/Makefile:63
> obj-$(CONFIG_SOUND_ICH)     += i810_audio.o ac97_codec.o
> 
> Some of the other sound drivers as modules that depend upon
> ac97_config.o do compile it.

eh?  It only needs to be compiled once, for all the modules that use it.

You don't compile it for each sound driver that uses it; it is a shared,
common module.

	Jeff



