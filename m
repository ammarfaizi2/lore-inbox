Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVLGV2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVLGV2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbVLGV2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:28:12 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:5048 "EHLO smtp12.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751792AbVLGV2L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:28:11 -0500
X-ME-UUID: 20051207212810261.3FB5E1C00085@mwinf1212.wanadoo.fr
Subject: Re: wrong number of serial port detected
From: Xavier Bestel <xavier.bestel@free.fr>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Jason Dravet <dravet@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051207211551.GL6793@flint.arm.linux.org.uk>
References: <20051207155034.GB6793@flint.arm.linux.org.uk>
	 <BAY103-F32F90C9849D407E9336826DF430@phx.gbl>
	 <20051207211551.GL6793@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 07 Dec 2005 22:28:05 +0100
Message-Id: <1133990886.6184.2.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 07 décembre 2005 à 21:15 +0000, Russell King a écrit :

> 4. User tries the well documented "setserial /dev/ttyS2 port 0x220 irq 5"
>    procedure, which has been supported since Linux 1.x
> 
> 5. User finds that, because there is no ttyS2 device in /dev, they
>    can't configure their card.

Well, instead of polluting everybody's /dev for the 3 users having such
cards, why not just tell the user to run
MAKEDEV /dev/ttyS2 ; setserial /dev/ttyS2 port 0x220 irq 5
instead ? (Or even mknod)

	Xav


