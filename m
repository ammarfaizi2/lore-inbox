Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314207AbSD0OVs>; Sat, 27 Apr 2002 10:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314208AbSD0OVr>; Sat, 27 Apr 2002 10:21:47 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:51890 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S314207AbSD0OVq>; Sat, 27 Apr 2002 10:21:46 -0400
Date: Sat, 27 Apr 2002 07:19:53 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: unnecessary use of set_bit
To: paulus@samba.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Message-id: <037201c1edf6$9a39c6e0$6800000a@krypton>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <15562.39130.683869.175699@argo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ohci_hub_status_data() procedure in drivers/usb/host/ohci-hub.c in
> 2.5.11 is broken in a couple of ways: it uses set_bit on a char *
> address and it assumes little-endian byte order in the bitmap.

Greg already submitted my patch to Linus, but I guess it didn't
make it in yet.  You'll be glad to know it stopped using set_bit().

Looks like your patch also preserves the API requirement that
the result be in little-endian byte order.

- Dave


