Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317457AbSGOMT4>; Mon, 15 Jul 2002 08:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSGOMTz>; Mon, 15 Jul 2002 08:19:55 -0400
Received: from [217.167.51.129] ([217.167.51.129]:16586 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S317457AbSGOMTy>;
	Mon, 15 Jul 2002 08:19:54 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
Date: Mon, 15 Jul 2002 14:22:46 +0200
Message-Id: <20020715122246.24495@192.168.4.1>
In-Reply-To: <200207150920.g6F9Kj7v019998@burner.fokus.gmd.de>
References: <200207150920.g6F9Kj7v019998@burner.fokus.gmd.de>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>How is it attached? Using FACL or ISCSI?
>
>In any case, it seems to be a natural solution to do it this way.
>
>In order to access a network disk, you need to obtain the right to
>do so first. Once this has been done, the netork subsystem just looks
>like a new SCSI bus.

The naming is nothing we should matter with. Ask Greg KH what he
thinks about kernel enforcing a naming policy ;)

What we are going to with 2.5 is a fully userland naming policy.

So if we end up defining a uniform API to send packet commands to
those type of devices (wether they are on a SCSI bus, ATAPI, USB,
1394, ...), then the best approach is probably for the various
drivers involved to declare a class "SCSI packet" in driverfs,
then let whatever userland naming policy decide how that should
be called. The internal kernel infrastructure (wether it'sa common
driver or split drivers providing you the same interface) is of
no matter to cdrecord.

Ben.


