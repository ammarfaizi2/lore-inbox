Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbWCWDta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbWCWDta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWCWDta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:49:30 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:24938 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S965162AbWCWDt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:49:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH] warn when statically-allocated kobjects are used
Date: Wed, 22 Mar 2006 22:49:22 -0500
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel@vger.kernel.org
References: <20060317013016.5C643E69@localhost.localdomain> <1142611444.3033.94.camel@laptopd505.fenrus.org> <20060317174352.GA2840@suse.de>
In-Reply-To: <20060317174352.GA2840@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603222249.22620.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 12:43, Greg KH wrote:
> On Fri, Mar 17, 2006 at 05:04:03PM +0100, Arjan van de Ven wrote:
> > 
> > > +warn:
> > > +	printk("---- begin silly warning ----\n");
> > > +	printk("This is a janitorial warning, not a kernel bug.\n");
> > 
> > technically it IS a kernel bug ;)
> 
> Until we fix up all of the struct bus and decl_subsys() usages in the
> kernel, this should show a lot of false positives...
> 

Plus IIRC ARM creates bunch of platform devices which are statically
allocated. But because they never get unregistered everything works
just fine.

-- 
Dmitry
