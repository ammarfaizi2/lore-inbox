Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTBPLzu>; Sun, 16 Feb 2003 06:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbTBPLzu>; Sun, 16 Feb 2003 06:55:50 -0500
Received: from holomorphy.com ([66.224.33.161]:36745 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266434AbTBPLzt>;
	Sun, 16 Feb 2003 06:55:49 -0500
Date: Sun, 16 Feb 2003 04:04:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Message-ID: <20030216120447.GN29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de> <20030216020808.GF9833@krispykreme> <20030216024317.GM29983@holomorphy.com> <1045377459.2175.0.camel@phantasy> <20030216071659.GB6417@actcom.co.il> <871y281m2d.fsf@student.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871y281m2d.fsf@student.uni-tuebingen.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda <mulix@mulix.org> writes:
>> I have no idea if that's what wli meant, but -1UL is only "all ones"
>> in a 2's complement binary representation. 

On Sun, Feb 16, 2003 at 12:50:34PM +0100, Falk Hueffner wrote:
> No. Wraparound of unsigned types is well-defined. -1UL must be the
> largest possible unsigned long value, which must consist of only 1
> bits (except for possible padding bits).
> Of course, no machines with ones-complement (or padding bits, or
> integer trap representations, or any of the other ISO braindamages)
> exist, so this is mostly irrelevant anyway.

In the "obvious" sense, -1UL is an oxymoron, as -1 is inherently signed,
and the "UL" says "unsigned".

It's aesthetic. It's a violation of what I consider good taste to
do signed bit twiddling on an unsigned value and/or vice-versa.
Regardless of what ISO and/or Linux may or may not support, the habits
ingrained in me wrt. portability say the assumption must not be made.

YMMV.

-- wli
