Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbSI2QD6>; Sun, 29 Sep 2002 12:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSI2QD6>; Sun, 29 Sep 2002 12:03:58 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:386 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262788AbSI2QD5>;
	Sun, 29 Sep 2002 12:03:57 -0400
Date: Sun, 29 Sep 2002 17:11:44 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] x86 BIOS Enhanced Disk Device (EDD) polling
Message-ID: <20020929161144.GA19948@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Matt Domsch <Matt_Domsch@Dell.com>, linux-kernel@vger.kernel.org
References: <20BF5713E14D5B48AA289F72BD372D6821CE34@AUSXMPC122.aus.amer.dell.com> <Pine.LNX.4.44.0209271606001.16331-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209271606001.16331-100000@humbolt.us.dell.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 04:30:29PM -0500, Matt Domsch wrote:
 >  arch/i386/kernel/edd.c           |  522 +++++++++++++++++++++++++++++++++++++++
 >  arch/i386/kernel/i386_ksyms.c    |    6 
 >  arch/i386/kernel/setup.c         |   20 +

Something that's been bothering me for a while, has been the
proliferation of 'driver' type things appearing in arch/i386/kernel/
My initial thought was to move the various CPU related 'drivers'
(msr,cpuid,bluesmoke,microcode) to arch/i386/cpu/  [1]
but I'm now wondering if an arch/i386/driver/ would be a better alternative.

Opinions?

		Dave

[1] also a more natural home for things like cpufreq if/when it gets integrated.
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
