Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263704AbUD1D44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbUD1D44 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUD1D44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:56:56 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:33745
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S263704AbUD1D4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:56:55 -0400
Subject: Re: [BK PATCH] add SMBIOS tables to sysfs
From: Michael Brown <Michael_E_Brown@Dell.com>
Reply-To: Michael_E_Brown@Dell.com
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, matt_domsch@dell.com
In-Reply-To: <20040428033020.GA14078@kroah.com>
References: <1083119269.1203.2821.camel@debian>
	 <20040428033020.GA14078@kroah.com>
Content-Type: text/plain
Organization: Dell Inc
Message-Id: <1083124552.1198.2835.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Apr 2004 22:55:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 22:30, Greg KH wrote:
> > +	snprintf(sdev->kobj.name, 7, "smbios" );
> 
> Try using kobject_set_name() instead, it will do the proper thing if the
> string is bigger than the base kobj.name field.

Looks like this API was added in Aug03. A quick grep through the tree
shows only <10 users. Are there patches pending to convert others, or
are you just having new stuff do this? I know of at least one sysfs
driver (edd) that uses snprintf() that could be converted. I'll send an
updated patch shortly for smbios.c, just curious.

--
Michael

