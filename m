Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTDRH3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 03:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbTDRH3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 03:29:48 -0400
Received: from granite.he.net ([216.218.226.66]:26884 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262914AbTDRH3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 03:29:44 -0400
Date: Fri, 18 Apr 2003 00:42:55 -0700
From: Greg KH <greg@kroah.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>,
       "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: Re: [patch] printk subsystems
Message-ID: <20030418074255.GC2753@kroah.com>
References: <3E9F0FD5.595B000B@opersys.com> <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C2630D5@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 02:03:47PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> Yep, that is the point, and it is small enough (5 ulongs) that 
> it can be embedded anywhere without being of high impact and 
> having to allocate it [first example that comes to mind is
> for sending a device connection message; you can embed a short
> message in the device structure and query that for delivery;
> no buffer, no nothing, the data straight from the source].

And the device is removed from the system, the memory for that device is
freed, and then a user comes along and trys to read that message.

oops...  :)

greg k-h
