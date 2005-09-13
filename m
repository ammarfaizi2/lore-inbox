Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVIMTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVIMTHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbVIMTHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:07:00 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:41711 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965057AbVIMTG6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:06:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V3JNFecgwNpu5eoE0qSzD0riyUObwWsSQ1wQzrDHkn8bn3nURr/W9N/+u0n/ENeSq9ZINRKdGRwxgUU3mm0A21z4Y1GKn8MNaZe7ogvvvdWvsY3bjolSn3TctXYvSf0QOnJAhvgqgZV/zoVuQY3LvqiP6tFNMU1UHQcyu60GA84=
Message-ID: <d120d5000509131206635b04e2@mail.gmail.com>
Date: Tue, 13 Sep 2005 14:06:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Subject: Re: [PATCH 0/2] Couple of I2O sysfs changes
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4326AAF8.2060702@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509122331.59554.dtor_core@ameritech.net>
	 <4326AAF8.2060702@shadowconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, Markus Lidel <Markus.Lidel@shadowconnect.com> wrote:
> > Also, it looks like i2o_device_class itself is not needed - correct
> > me if I am wrong, but all i2o devics reside on their own bus so
> > i2o_devices class simply mirrors iformation from the bus and can
> > also be safely removed.
> 
> Nope, there is one bus per controller not per device...
> 

That is what I was trying to say. Well, not exactly... What I was
really trying to say is AFAIKS I2O system registers only one sysfs bus
object and all I2O devices reside on it. Unlike, for exaple input
objects, that can appear on serio, gameport, usb buses and so on. So
if one wants to see all I2O devices in sysfs he could just check
/sys/bus/i2o/devices/ and see them all there.

-- 
Dmitry
