Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262461AbSI2Mv3>; Sun, 29 Sep 2002 08:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSI2Mv2>; Sun, 29 Sep 2002 08:51:28 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:33298 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S262461AbSI2Mv2>; Sun, 29 Sep 2002 08:51:28 -0400
Date: Sun, 29 Sep 2002 22:56:33 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Greg KH <greg@kroah.com>
cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
       <linux-kernel@vger.kernel.org>, <linux-security-module@wirex.com>
Subject: Re: [PATCH] accessfs v0.6 ported to 2.5.35-lsm1 - 1/2
In-Reply-To: <20020927214642.GS12909@kroah.com>
Message-ID: <Mutt.LNX.4.44.0209292236200.27145-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2002, Greg KH wrote:

> On Fri, Sep 27, 2002 at 08:55:52PM +0200, Olaf Dietsche wrote:
> >  
> > +static int cap_ip_prot_sock (int port)
> > +{
> > +	if (port && port < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
> > +		return -EACCES;
> > +
> > +	return 0;
> > +}
> > +
> 
> Do we really want to force all of the security modules to implement this
> logic (yes, it's the same discussion again...)
> 
> As for the ip_prot_sock hook in general, does it look ok to the other
> developers?
> 

This hook is not necessary: any related access control decision can be
made via the more generic and flexible socket_bind() hook (like SELinux).


- James
-- 
James Morris
<jmorris@intercode.com.au>


