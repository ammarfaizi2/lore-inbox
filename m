Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314025AbSDQCFL>; Tue, 16 Apr 2002 22:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314026AbSDQCFK>; Tue, 16 Apr 2002 22:05:10 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52998
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314025AbSDQCFK>; Tue, 16 Apr 2002 22:05:10 -0400
Date: Tue, 16 Apr 2002 19:04:32 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gerard Beekmans <gerard@linuxfromscratch.org>
cc: linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: make xconfig fails in 2.5.8 kernel, trivial change to fix it
In-Reply-To: <20020416224524.GA5651@gwaihir.linuxfromscratch.org>
Message-ID: <Pine.LNX.4.10.10204161902220.11230-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gerard,

I am sorry I can not answer you questions about 2.5, since there is a new
maintainer.  I am sure he can resolve your 2.5 issue proper.

Andre Hedrick
The Second Linux X-IDE guy

 
On Tue, 16 Apr 2002, Gerard Beekmans wrote:

> Hi,
> 
> There is a very trivial problem in line 52 of the drivers/ide/Config.in
> file. It reads:
> 	if [ $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT != "n" ]; then
> 
> 'make xconfig' fails on this saying that it is a bad if condition:
> 
> 	cat header.tk >> ./kconfig.tk
> 	./tkparse < ../arch/i386/config.in >> kconfig.tk
> 	drivers/ide/Config.in: 52: bad if condition
> 
> It is easily fixed by enclosing $CONFIG_BLK_DEV_IDE_TCQ_DEFAULT in double
> quotes. There are other if conditions in this same file that do have those
> quotes and Tk doesn't complain about them.
> 
> Does anybody use xconfig these days anyways since nobody apprarently has
> noticed it before? I saw this broken a few 2.5 releases ago too but never
> got around looking into it.
> 
> 
> 
> -- 
> Gerard Beekmans
> www.linuxfromscratch.org
> 
> -*- If Linux doesn't have the solution, you have the wrong problem -*-
> 

