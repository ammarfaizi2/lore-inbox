Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVCIQf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVCIQf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVCIQf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:35:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:22667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261503AbVCIQfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:35:48 -0500
Date: Wed, 9 Mar 2005 08:31:13 -0800
From: Greg KH <greg@kroah.com>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309163113.GB25079@kroah.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <20050228065534.GC23595@kroah.com> <4228CE5C.9010207@us.ltcfwd.linux.ibm.com> <20050305064445.GA8447@kroah.com> <422CDA58.5000506@us.ltcfwd.linux.ibm.com> <20050308064211.GE17022@kroah.com> <422DF217.8070401@us.ltcfwd.linux.ibm.com> <20050309060450.GA17560@kroah.com> <422F1B2C.6070405@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422F1B2C.6070405@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:50:04AM -0500, Wen Xiong wrote:
> +/* Ioctls needed for dpa operation */
> +#define DIGI_GETDD	('d'<<8) | 248		/* get driver info      */
> +#define DIGI_GETBD	('d'<<8) | 249		/* get board info       */
> +#define DIGI_GET_NI_INFO ('d'<<8) | 250		/* nonintelligent state snfo */

Hm, new ioctls still?...

And the structures you are attempting to access through these ioctls are
incorrect, so if you are still insisting you need them, at least make
the code work properly :(

thanks,

greg k-h
