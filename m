Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWDCJMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWDCJMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWDCJMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:12:06 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:31925 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751682AbWDCJMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:12:05 -0400
Date: Mon, 3 Apr 2006 11:11:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Arjan van de Ven <arjan@infradead.org>, Ben Ford <ben@kalifornia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Who wants to test cracklinux??
In-Reply-To: <1144019771.31123.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0604031109500.2220@yvahk01.tjqt.qr>
References: <20060328221223.80753cab.letterdrop@gmx.de>  <20060328224929.GC5760@elf.ucw.cz>
  <44305193.5080408@kalifornia.com>  <1144017581.3066.34.camel@testmachine>
 <1144019771.31123.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1352155675-1144055491=:2220"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1352155675-1144055491=:2220
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> is there any difference? I mean... if you can outb you for all intents
>> and purposes are root anyway ;) (like you can overwrite any memory in
>> the system etc etc)
>
>There are two clear uses
>
>#1	Its possible to write such a module to allow only some ports to be
>accessed, eg to export a PCI device for learning purposes
>
You can do parts of that in userspace, which is A Good Thing(tm).

Write a SUID wrapper which ioperm's (or denies it) a range request, opens 
/dev/mem or /dev/port and then drops privilegues. Voilà.

(Not sure if outb requires root too, besides ioperm.)


Jan Engelhardt
-- 
--1283855629-1352155675-1144055491=:2220--
