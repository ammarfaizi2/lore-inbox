Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTL3XwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbTL3XwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:52:17 -0500
Received: from magic-mail.adaptec.com ([216.52.22.10]:39042 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S264401AbTL3XwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:52:12 -0500
Date: Tue, 30 Dec 2003 16:57:49 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@pobox.com>, Mickael Marchand <marchand@kde.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adaptec 1210sa
Message-ID: <641152704.1072828669@aslan.btc.adaptec.com>
In-Reply-To: <3FF20B7A.1090108@pobox.com>
References: <200312220305.29955.marchand@kde.org> <3FF20B7A.1090108@pobox.com>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> the idea suggested by Justin was to clear bits 6 and 7 at 0x8a of pci 
>> configuration space. (which I hope did fine :)
>> 
>> Thanks Justin :)
> 
> 
> Does the aar1210 have a different PCI id?  That would make it easy to
> distinguish, and thus easy to selectively apply your patch only to Adaptec
> chipsets that need it.

The change is harmless for controllers using non-adaptec BIOSes.  You'll
find that on these other controllers, the interrupt masks are already
clear.  If this wasn't the case, the current Linux driver wouldn't work
even on stock boards.

--
Justin

