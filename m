Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSG3Sg7>; Tue, 30 Jul 2002 14:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSG3Sg7>; Tue, 30 Jul 2002 14:36:59 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63215 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312558AbSG3Sg6>; Tue, 30 Jul 2002 14:36:58 -0400
Subject: Re: PATCH: 2.5.29 Fix cmd640 config locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       martin@dalecki.de
In-Reply-To: <200207301810.LAA02575@baldur.yggdrasil.com>
References: <200207301810.LAA02575@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 20:55:54 +0100
Message-Id: <1028058954.7886.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 19:10, Adam J. Richter wrote:
> >From drivers/ide/cmd640.c:
> 
> | /*
> |  * The CMD640x chip does not support DWORD config write cycles, but some
> |  * of the BIOSes use them to implement the config services.
> | * Therefore, we must use direct IO instead.
> | */
> 
> >From Alan's patch to cmd640, derived frmo Andre Hedrick's
> "ide-2.4.19-p8-0ac1.all.covert.10.patch" posted on 2002-07-25 10;51:07 at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102759487724962&w=2:

I've just been fixing the locking to use pci_lock, and the probe. Other
changes may be intentional Andre ones or unintentional ones.

