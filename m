Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292903AbSBVPej>; Fri, 22 Feb 2002 10:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292904AbSBVPe3>; Fri, 22 Feb 2002 10:34:29 -0500
Received: from trained-monkey.org ([209.217.122.11]:65287 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S292903AbSBVPeT>; Fri, 22 Feb 2002 10:34:19 -0500
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15478.25845.343591.883309@trained-monkey.org>
Date: Fri, 22 Feb 2002 10:34:13 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <3C76631C.E685815D@mandrakesoft.com>
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
	<20020207234555.N17426@altus.drgw.net>
	<5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
	<d37kp5v9y5.fsf@lxplus050.cern.ch>
	<3C7660F5.FC238A7E@mandrakesoft.com>
	<15478.25001.512565.628500@trained-monkey.org>
	<3C76631C.E685815D@mandrakesoft.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

Jeff> Jes Sorensen wrote:
>>  Why? CONFIG_$ARCH only makes sense if you can enable two
>> architectures in the same build. What does CONFIG_M68K give you that
>> __mc68000__ doesn't provide?

Jeff> 1) it is a Linux kernel standard.  all arches save two define
Jeff> CONFIG_$arch.

Ehm, what standard? the standard way has always been ARCH==, CONFIG_PPC
used to be the only place using this and all it did was to make things
uglier and inconsistent.

Jeff> 2) you have two tests, "ARCH==m68k" in config.in and "__mc68000__"
Jeff> in C code.  CONFIG_M68K means you only test one symbol, the same
Jeff> symbol, in all code.

If you want to do that, then one should use CONFIG_<ARCH> in the
Makefiles as well.

Jeff> 3) as this thread shows, due to #1, users -expect- that
Jeff> CONFIG_M68K will exist

Ehm, most kernel developers will expect ARCH== in Config.in as thats
how it's always been.

Jes
