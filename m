Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTDOMLc (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbTDOMLc 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:11:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21438
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261288AbTDOMLb (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:11:31 -0400
Subject: Re: Problem: 2.4.20, 2.5.66 have different IDE channel order
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304142054_MC3-1-3463-6D74@compuserve.com>
References: <200304142054_MC3-1-3463-6D74@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050405826.27744.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 12:23:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 01:51, Chuck Ebbert wrote:
>     PIIX3, HPT370, PDC20268
> 
>   Obviously reversing order isn't going to help here.
> 
>   I edited the Makefile to change the link order but that didn't help.

For compiled in IDE the order is defined by the order on the PCI
bus scan, not by the IDE layer

(See ide/setup-pci.c:ide_scan_pcibus)

