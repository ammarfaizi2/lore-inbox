Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWGAIZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWGAIZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 04:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWGAIZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 04:25:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26304 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932447AbWGAIZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 04:25:20 -0400
Subject: Re: [PATCH] FIX and enable EDAC sysfs operation
From: Arjan van de Ven <arjan@infradead.org>
To: Doug Thompson <norsk5@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060701002936.65377.qmail@web50112.mail.yahoo.com>
References: <20060701002936.65377.qmail@web50112.mail.yahoo.com>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 10:25:14 +0200
Message-Id: <1151742314.3195.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 17:29 -0700, Doug Thompson wrote:
> The sysfs is now enabled in this patch, with a minimal set of control and attribute
> files for examining EDAC state and for enabling/disabling the memory and PCI
> operations.
> 

unfortunately this is still buggy ;-(

> +/* No memory to release for this kobj */
>  static void edac_csrow_instance_release(struct kobject *kobj)
>  {
>  	struct csrow_info *cs;
>  
> -	debugf1("%s()\n", __func__);
>  	cs = container_of(kobj, struct csrow_info, kobj);
>  	complete(&cs->kobj_complete);
>  }


because this is still invalid behavior!


