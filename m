Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136084AbREGKx4>; Mon, 7 May 2001 06:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136088AbREGKxr>; Mon, 7 May 2001 06:53:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23304 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136084AbREGKxh>; Mon, 7 May 2001 06:53:37 -0400
Subject: Re: what causes Machine Check exception? revisited (2.2.18)
To: juhan@cc.ioc.ee (Juhan-Peep Ernits)
Date: Mon, 7 May 2001 11:57:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105071127100.20861-100000@suhkur.cc.ioc.ee> from "Juhan-Peep Ernits" at May 07, 2001 11:50:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wihd-0003LT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After searching the archives of the list I found some similar reports
> from September and December 2000 but as far as I understood the cause of
> the error was blamed on the CPU. Is this the most probable case? 

A machine check (trap 18) is signalled by the processor when it thinks it is
in an invalid state. Many x86 cpus have checking circuitry and the default
behaviour is to either reboot or continue-and-pray. 

Linux enables notification of these events. So yes your processor was unhappy.
But it can be unhappy because of wrong voltages, electrical noise, overheating
and many other things.

Generally it indicates a CPU problem but I've see it caused by overclocking
and poorly fitted heatsinks

