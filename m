Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWEVLOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWEVLOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWEVLOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:14:34 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:34982 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750738AbWEVLOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:14:33 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not working on 2.6.16
Date: Mon, 22 May 2006 21:14:11 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Barry Scott <barry.scott@onelan.co.uk>
References: <4469E709.7080501@onelan.co.uk> <20060522035943.7829ee32.akpm@osdl.org>
In-Reply-To: <20060522035943.7829ee32.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605222114.12165.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 20:59, Andrew Morton wrote:
> It appears that the 2.6.13 kernel did not bring up the machine's io-APICs,
> but 2.6.16 did.  However you are receiving eth0 interrupts on 2.6.16 so
> perhaps that's not relevant.

It looks like he's _not_ receiving eth0 interrupts if I'm not mistaken?

The lower one with apic presumably is 2.6.16


>  10:        130          XT-PIC  eth0

>  16:          0   IO-APIC-level  eth0

and this:

> ENABLING IO-APIC IRQs
> ..TIMER: vector=0x31 apic1=-1 pin1=-1 apic2=-1 pin2=-1
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ... works.

looks suspiciously like a broken apic/code/workaround/whatever

I'd go with Andrew's suggestion and disable apic in your bootparameters 
(noapic and/or nolapic) and possibly in your config if it corrects it

-- 
-ck
