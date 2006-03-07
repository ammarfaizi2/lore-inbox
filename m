Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWCGRGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWCGRGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCGRGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:06:50 -0500
Received: from smtp-4.llnl.gov ([128.115.41.84]:59365 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S1751284AbWCGRGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:06:49 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Tue, 7 Mar 2006 09:06:36 -0800
User-Agent: KMail/1.5.3
Cc: Al Viro <viro@ftp.linux.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       dthompson@lnxi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603070847.44417.dsp@llnl.gov> <20060307170401.GA6989@kroah.com>
In-Reply-To: <20060307170401.GA6989@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603070906.36196.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 09:04, Greg KH wrote:
> >     - Modify EDAC so it uses kmalloc() to create the kobject.
> >     - Eliminate edac_memctrl_master_release().  Instead, use kfree() as
> >       the release method for the kobject.  Here, it's important to use a
> >       function -outside- of EDAC as the release method since the core
> >       EDAC module may have been unloaded by the time the release method
> >       is called.
>
> No, if this happens then you are using the kobject incorrectly.  How
> could it be held if your module is unloaded?  Don't you have the module
> reference counting logic correct?

Oops... my mistake.
