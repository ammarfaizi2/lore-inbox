Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUFVXYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUFVXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUFVXX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:23:28 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:53609 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263778AbUFVXVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:21:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.7
Date: Tue, 22 Jun 2004 18:21:01 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>
References: <1087926108744@kroah.com>
In-Reply-To: <1087926108744@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406221821.02128.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 12:41 pm, Greg KH wrote:

>  
>  void class_unregister(struct class * cls)
>  {
>  	pr_debug("device class '%s': unregistering\n",cls->name);
> +	remove_class_attrs(cls);
>  	subsystem_unregister(&cls->subsys);
>  }
>  

Question: is it necessary to call remove_class_attrs? I thought that sysfs
automatically destroys all children when parent is destroyed? Am I imagining
things?
 
-- 
Dmitry
