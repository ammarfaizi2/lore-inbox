Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVGDKup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVGDKup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGDKuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:50:44 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:32960 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261619AbVGDKt4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:49:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rhvn+9x8L7HuhkZ8ZkR+i++pLoN8WF6wkOzcXY8yi7bNp4OodcasoOJe7TsDY0uRf+Mm1wU9CZ+c6CIsvb1EPEG6Zy+p0ZE7jTnYD8ZNoiKv0azFjHupM/Crs4hyqVE7vnO3XXudFiDN8GHqUGFIJlhL8i/aIKsM/SJh9l3vl2k=
Message-ID: <84144f020507040349e4b9723@mail.gmail.com>
Date: Mon, 4 Jul 2005 13:49:54 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490507031832546f383a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490507031832546f383a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesper,

On 7/4/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> static int
> ibm_hdaps_open(struct inode *inode, struct file *filp)
> {
> 	printk("%s() start\n", __func__);
> 	if (!atomic_dec_and_test(&ibm_hdaps_available)) {
> 		printk("%s() busy\n", __func__);
> 		atomic_inc(&ibm_hdaps_available);
> 		return -EBUSY;
> 	}
> 	printk("%s() good\n", __func__);
> 
> 	filp->private_data = kmalloc(sizeof(struct hdaps_accel_data), GFP_KERNEL);

You seem to be leaking private_data.

                                    Pekka
