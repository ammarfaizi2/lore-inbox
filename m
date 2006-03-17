Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbWCQRoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWCQRoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWCQRoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:44:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:16038
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030215AbWCQRoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:44:06 -0500
Date: Fri, 17 Mar 2006 09:43:52 -0800
From: Greg KH <gregkh@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] warn when statically-allocated kobjects are used
Message-ID: <20060317174352.GA2840@suse.de>
References: <20060317013016.5C643E69@localhost.localdomain> <1142611444.3033.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142611444.3033.94.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 05:04:03PM +0100, Arjan van de Ven wrote:
> 
> > +warn:
> > +	printk("---- begin silly warning ----\n");
> > +	printk("This is a janitorial warning, not a kernel bug.\n");
> 
> technically it IS a kernel bug ;)

Until we fix up all of the struct bus and decl_subsys() usages in the
kernel, this should show a lot of false positives...

thanks,

greg k-h
