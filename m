Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVBHMYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVBHMYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVBHMYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:24:03 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:42474 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261520AbVBHMYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:24:00 -0500
Date: Tue, 8 Feb 2005 13:23:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matthew Wilcox <matthew@wil.cx>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
In-Reply-To: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.61.0502081322310.6118@scrub.home>
References: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Feb 2005, Matthew Wilcox wrote:

> 
> David Holland pointed out that Make has a lot of implicit suffix rules
> built in and you can disable them by setting ".SUFFIXES:".  As an
> example, checking the debugging information shows we no longer try to
> compile anything from a '.f' suffix.  This turns out to be good for a 15%
> speedup on a build with nothing to do; down from 29.1 seconds to 24.7
> seconds on my K6.

Enabling the following in the Makefile should have the same effect:

# For maximum performance (+ possibly random breakage, uncomment
# the following)

#MAKEFLAGS += -rR

bye, Roman
