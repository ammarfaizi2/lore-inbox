Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262151AbSJAQli>; Tue, 1 Oct 2002 12:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSJAQli>; Tue, 1 Oct 2002 12:41:38 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:63090 "EHLO
	elipse.com.br") by vger.kernel.org with ESMTP id <S262151AbSJAQlJ>;
	Tue, 1 Oct 2002 12:41:09 -0400
Message-ID: <029401c2696a$9adc8bb0$1c00a8c0@elipse.com.br>
Reply-To: "Felipe W Damasio" <felipewd@elipse.com.br>
From: "Felipe W Damasio" <felipewd@elipse.com.br>
To: "Kent Yoder" <key@austin.ibm.com>, "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <tsbogend@alpha.franken.de>
References: <Pine.LNX.4.44.0210011129330.14607-100000@ennui.austin.ibm.com>
Subject: Re: [PATCH] pcnet32 cable status check
Date: Tue, 1 Oct 2002 13:50:10 -0300
Organization: Elipse Software
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 01 Oct 2002 16:50:10.0546 (UTC) FILETIME=[9ADD9D20:01C2696A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Kent Yoder" <key@austin.ibm.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>; <tsbogend@alpha.franken.de>
Sent: Tuesday, October 01, 2002 1:34 PM
Subject: Re: [PATCH] pcnet32 cable status check


>
>   Hi,
>
>   Here's the updated version, now dependent on Jeff's new mii code.  This
is
> a bit more modular as well and new functionality can be added inside the
> watchdog function without anything depending on mii.

    You should use netif_carrier_{on|off} to notify the upper layer of a
link change/loss (until the otherwise is true). Check the 8139cp driver.

    Also, you shouldn't need the timer stuff to keep track of link change.
Just the mii_check_media and netif_carrier_{on|off} and you should be fine.

Felipe

