Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUJVX0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUJVX0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUJVXZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:25:48 -0400
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:14765 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S269233AbUJVXWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:22:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9] HPT372N - oops (NULL pointer dereference)
References: <m23c09p01z.fsf@rohan.middle-earth.priv>
From: Ronald Wahl <ronald.wahl@informatik.tu-chemnitz.de>
Date: Sat, 23 Oct 2004 00:58:35 +0200
In-Reply-To: <m23c09p01z.fsf@rohan.middle-earth.priv> (Ronald Wahl's message
 of "Wed, 20 Oct 2004 23:11:20 +0200")
Message-ID: <m21xfqpdgk.fsf@rohan.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 2.64 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 8a8fa125b9cc748093f12ed7809f170b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 23:11:20 +0200, Ronald Wahl wrote:

> Hello,
> I just tried upgrading from 2.6.7 to 2.6.9 and got a kernel oops during
> boot. Stack trace looked very similar to the one João Luis Meloni Assirati
> reported on Oct 05 2004 (Subject: hpt366 under hpt372N oops). I have a
> HPT372N on my board with one disk attached.

> Is there any news on this issue yet? It keeps me from using 2.6.9. :-/

Since no one seems to care about it I had a quick look by myself into
drivers/ide/pci/hpt366.c:

For the HPT372N pci_get_drvdata(dev) will return NULL and this will
result in an oops during pci_bus_clock_list() which is called from
hpt372_tune_chipset().

- ron
