Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUDYAXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUDYAXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 20:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUDYAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 20:23:39 -0400
Received: from pop.gmx.de ([213.165.64.20]:896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261992AbUDYAXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 20:23:38 -0400
X-Authenticated: #555161
Message-ID: <408B046B.9040306@hasw.net>
Date: Sun, 25 Apr 2004 02:20:59 +0200
From: Sebastian Witt <se.witt@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com
Subject: Re: PROBLEM: Oops when using both channels of the PDC20262
References: <40898ADA.8020708@hasw.net> <200404242242.36154.vda@port.imtp.ilyichevsk.odessa.ua> <200404242230.20985.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200404242230.20985.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
 >
 > There were some change in pdc202xx_old.c driver in 2.6.2.
 > Please revert this patch and report if it helps.

I've tested 2.6.2 with the reverted patch and it seems to work.
Normally it takes <1min to crash the system when I access the discs
on the controller, with the patched driver it works >1 hour without a error.

Also I've copied the driver to the 2.6.5 tree now trying this (after 
disabling the procfs code, it seems that it has changed).

 >
 > Strange, it looks like IO-APIC problem.
 > Have you tried booting with "noapic" kernel parameter?

Yes, then /proc/interrupts shows that it uses the XT-PIC, but it also
crashes (now without a Oops, totally freezed).

