Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSEMLow>; Mon, 13 May 2002 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSEMLou>; Mon, 13 May 2002 07:44:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22802 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313038AbSEMLoo>; Mon, 13 May 2002 07:44:44 -0400
Subject: Re: pdc202xx.c fails to compile in 2.5.15
To: vandrove@vc.cvut.cz (Petr Vandrovec)
Date: Mon, 13 May 2002 13:03:27 +0100 (BST)
Cc: zlatko.calusic@iskon.hr (Zlatko Calusic),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20020512220008.GA2935@ppc.vc.cvut.cz> from "Petr Vandrovec" at May 13, 2002 12:00:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177EY3-0005DN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have PDC20265 like I have, you must also remove test on device class,
> as 20265 reports itself as generic mass storage (class 0x0180) and not as
> IDE (it is real IDE, not RAID, really). 

It reports itself that way so that the windows ide disk driver doesn't
grab and it and dos/bios don't get odd ideas

> Because of there are apparently devices on which you must check device class
> (2.5.14 talks about CY82C693 and IT8172G), I'll leave proper fix on Martin,
> but simple fix below work fine on my Asus A7V.

You need to do specific checks for the device in question. Removing the
class check btw is something anyone reading this message should not do
even in the same situation unless they know precisely what other
mass storage class devices they have present. You can easily trash a
raid array otherwise
