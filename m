Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWALSzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWALSzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbWALSzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:55:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16612 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932666AbWALSzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:55:24 -0500
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
From: Arjan van de Ven <arjan@infradead.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Gerd Hoffmann <kraxel@suse.de>,
       "Mike D. Day" <ncmike@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
In-Reply-To: <43C6A5B4.80801@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>
	 <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>
	 <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de>
	 <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de>
	 <20060112173926.GD10513@kroah.com>  <43C6A5B4.80801@us.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 19:55:19 +0100
Message-Id: <1137092120.2936.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 12:53 -0600, Anthony Liguori wrote:
> 
> We wish to make management hypercalls as the root user in userspace 
> which means we have to go through the kernel.  Currently, we do this
> by 
> having /proc/xen/privcmd accept an ioctl() that takes a structure
> that 
> describe the register arguments.  The kernel interface allows us to 
> control who in userspace can execute hypercalls.

ioctls on proc is evil though (so is ioctl-on-sysfs). It's a device not
a proc file!


