Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318708AbSHQTkM>; Sat, 17 Aug 2002 15:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318711AbSHQTkM>; Sat, 17 Aug 2002 15:40:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23282 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318708AbSHQTkM>; Sat, 17 Aug 2002 15:40:12 -0400
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D5D7E50.4030307@netscape.net>
References: <3D5D7E50.4030307@netscape.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Aug 2002 20:43:26 +0100
Message-Id: <1029613406.4647.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 23:36, Adam Belay wrote:
> +static ssize_t device_read_driver(struct device * dev, char * buf, 
> size_t count, loff_t off)
> +{
> +    if (dev->driver)
> +        return off ? 0 : sprintf(buf,"%s\n",dev->driver->name);
> +    else
> +        return 0;

Unless you can prove without doubt between now and the end of time the
size is sufficient use snprintf 


