Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVBIABa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVBIABa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVBIABa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:01:30 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:21834 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261704AbVBIABU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:01:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OvQbQLt8qac7b/TTCDX8JamVJ4Dk/+Apy9jjjlVLl4jZARSz2a39DpxuSdVxeZBTfMih2gijP2Iu9AC2ZKu4E9JSUSMS8DtoBOABVC0dgr0zDOYfV2AxwLG40fw/3nXA4wktjwMIorzhZs6RngHOQRC70lyT7HSqxOJQk7jGB6Y=
Message-ID: <58cb370e05020816017431b38@mail.gmail.com>
Date: Wed, 9 Feb 2005 01:01:20 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <42094ADB.9040403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42094ADB.9040403@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a minor thing

> +static int __devinit
> +mv64xxx_i2c_init(void)
> +{
> +       return driver_register(&mv64xxx_i2c_driver);
> +}

__init

> +static void __devexit
> +mv64xxx_i2c_exit(void)
> +{
> +       driver_unregister(&mv64xxx_i2c_driver);
> +       return;
> +}

__exit

these functions relate to module not device

> +module_init(mv64xxx_i2c_init);
> +module_exit(mv64xxx_i2c_exit);
