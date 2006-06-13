Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWFMLW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWFMLW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFMLW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:22:29 -0400
Received: from gw.openss7.com ([142.179.199.224]:12200 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750989AbWFMLWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:22:20 -0400
Date: Tue, 13 Jun 2006 05:22:15 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060613052215.B27858@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060613140716.6af45bec@localhost.localdomain>; from shemminger@osdl.org on Tue, Jun 13, 2006 at 02:07:16PM +0900
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

On Tue, 13 Jun 2006, Stephen Hemminger wrote:

> > @@ -2176,3 +2279,13 @@ EXPORT_SYMBOL(sock_wake_async);
> >  EXPORT_SYMBOL(sockfd_lookup);
> >  EXPORT_SYMBOL(kernel_sendmsg);
> >  EXPORT_SYMBOL(kernel_recvmsg);
> > +EXPORT_SYMBOL(kernel_bind);
> > +EXPORT_SYMBOL(kernel_listen);
> > +EXPORT_SYMBOL(kernel_accept);
> > +EXPORT_SYMBOL(kernel_connect);
> > +EXPORT_SYMBOL(kernel_getsockname);
> > +EXPORT_SYMBOL(kernel_getpeername);
> > +EXPORT_SYMBOL(kernel_getsockopt);
> > +EXPORT_SYMBOL(kernel_setsockopt);
> > +EXPORT_SYMBOL(kernel_sendpage);
> > +EXPORT_SYMBOL(kernel_ioctl);
> 
> Don't we want to restrict this to GPL code with EXPORT_SYMBOL_GPL?

There are direct derivatives of the BSD/POSIX system call
interface.  The protocol function pointers within the socket
structure are not GPL only.  Why make this wrappered access to
them GPL only?  It will only encourange the reverse of what they
were intended to do: be used instead of the protocol function
pointers within the socket structure, that currently carry no
such restriction.

