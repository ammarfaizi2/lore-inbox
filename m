Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVG1RM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVG1RM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVG1Qgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:36:50 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:30349 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261661AbVG1Qfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:35:34 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Rahul Tank <rahul5311@yahoo.co.in>
Subject: Re: serial device driver
Date: Thu, 28 Jul 2005 10:35:31 -0600
User-Agent: KMail/1.8.1
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050727111225.3662.qmail@web8410.mail.in.yahoo.com>
In-Reply-To: <20050727111225.3662.qmail@web8410.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507281035.31128.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 July 2005 5:12 am, Rahul Tank wrote:
>    i am writing a serial device driver. After going
> thru few linux journals i have understood that serial
> ports get mapped at standard addrerss.We need to take
> these regions, register driver and talk to them
> (read,write).

If your device is 8250/16550/etc compatible, you should
be able to use the existing 8250.c serial driver.  If
your device is attached via PCI, look at 8250_pci.c for
examples of how to claim it.  I think if your device
claims to be PCI_CLASS_COMMUNICATION_SERIAL, 8250_pci.c
will claim it automatically with no code changes at all.
