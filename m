Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWGLDha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWGLDha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWGLDha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:37:30 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:452 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932391AbWGLDh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:37:29 -0400
Date: Wed, 12 Jul 2006 05:37:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Petr Vandrovec <petr@vandrovec.name>
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
Message-ID: <20060712033722.GA13096@mars.ravnborg.org>
References: <1152631729.3373.197.camel@pmac.infradead.org> <44B435DE.4040708@vandrovec.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B435DE.4040708@vandrovec.name>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, it is probably unnecessary to include config.h for about eight 
> months, but as it is not present in feature-removal-schedule.txt I've 
> missed it.  Thanks for pointing it out...
Obsoleting a header is not a "feature-removal" per se.

> FYI, fortunately (for you, unfortunately for VMware) 2.6.18's already broke 
> our build script due to UTS_RELEASE being moved to separate file, so from 
> VMware's viewpoint killconfig.h.git will not do any additional damage...
#include <linux/config.h>
#ifndef UTS_RELEASE
#include <linux/utsrelease.h>
#endif

Then one can wonder why WMware needs UTS_RELEASE?

	Sam
