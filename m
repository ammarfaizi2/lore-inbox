Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965458AbWIRGN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965458AbWIRGN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965459AbWIRGN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:13:26 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:41090 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965458AbWIRGN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:13:26 -0400
Subject: Re: [Bluez-devel] bluetooth drivers : kmalloc to kzalloc conversion
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
References: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 08:13:28 +0200
Message-Id: <1158560008.30486.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Om,

> Tested by compiling with $make allmodconfig; make
> 
> Signed off by Om Narasimhan <om.turyx@gmail.com>
> 
>  drivers/bluetooth/bfusb.c   |    2 +-
>  drivers/bluetooth/hci_usb.c |   11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)

the kzalloc is suppose to replace a kmalloc followed by a memset
operation. It is not the case for these changes and so these changes
make no sense.

Regards

Marcel


