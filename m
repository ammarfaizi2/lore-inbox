Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVCROj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVCROj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCROj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:39:59 -0500
Received: from smarthost2.sentex.ca ([205.211.164.50]:3588 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S261614AbVCROj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:39:57 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Jacques Goldberg'" <Jacques.Goldberg@cern.ch>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Need break driver<-->pci-device automatic association
Date: Fri, 18 Mar 2005 09:39:54 -0500
Organization: Connect Tech Inc.
Message-ID: <003c01c52bc8$59774750$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.58_heb2.09.0503181537400.9143@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacques Goldberg
>   To be ugly or to never be up to date, that's the question.
>   We did patch 8250_pci.c but there is no way to build a 
> stable list of
> the devices to be handled that way.
>   We will thus spend some time on the hot unplug solution.

I think what you want might be accomplished if the serial driver was
compiled as a module. Then have your driver grab all the PCI devices
it wants, and they shouldn't be grabbed by the serial driver when it
loads. If you can't get your driver to load before the serial driver
for whatever reason, unloading the serial driver should give up the
devices it had claimed.

..Stu

