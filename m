Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWAQUnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWAQUnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAQUnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:43:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8138 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932429AbWAQUnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:43:41 -0500
Date: Tue, 17 Jan 2006 12:43:14 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Fix warning on 64bit boxes
Message-Id: <20060117124314.26823ae7.zaitcev@redhat.com>
In-Reply-To: <1137520565.14135.45.camel@localhost.localdomain>
References: <1137520565.14135.45.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006 17:56:05 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> We cast an int to a void * which not unreasonably makes gcc suspicious.
> We don't actually care what type "type" is so use unsigned long so it
> matches pointer length on all platforms.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

>  static int usu_probe(struct usb_interface *intf,
>  			 const struct usb_device_id *id)
>  {
> -	int type;
> +	unsigned long type;

Looks good to me.

Acked-by: Pete Zaitcev <zaitcev@redhat.com>

-- Pete
