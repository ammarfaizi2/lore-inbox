Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWE3SfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWE3SfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWE3SfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:35:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932314AbWE3Se7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:34:59 -0400
Date: Tue, 30 May 2006 11:33:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: lcapitulino@mandriva.com.br, frank.gevaerts@fks.be,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: usb-serial ipaq kernel problem
Message-Id: <20060530113327.297aceb7.zaitcev@redhat.com>
In-Reply-To: <20060530174821.GA15969@fks.be>
References: <20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
	<20060530115329.30184aa0@doriath.conectiva>
	<20060530174821.GA15969@fks.be>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 19:48:21 +0200, Frank Gevaerts <frank.gevaerts@fks.be> wrote:
+0100
> +++ linux-2.6.17-rc4.test/drivers/usb/serial/ipaq.c	2006-05-30 19:41:19.000000000 +0200
> @@ -692,6 +694,7 @@ static void ipaq_close(struct usb_serial
>  	struct ipaq_private	*priv = usb_get_serial_port_data(port);
>  
>  	dbg("%s - port %d", __FUNCTION__, port->number);
> +
>  			 
>  	/*
>  	 * shut down bulk read and write

Please get rid of the above.

> @@ -967,3 +971,6 @@ MODULE_PARM_DESC(vendor, "User specified
>  
>  module_param(product, ushort, 0);
>  MODULE_PARM_DESC(product, "User specified USB idProduct");
> +
> +module_param(connect_retries, int, KP_RETRIES);
> +MODULE_PARM_DESC(product, "Maximum number of connect retries (100ms each)");

Personally, I'm not keen on adding knobs.

-- Pete
