Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWFMOHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWFMOHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWFMOHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:07:49 -0400
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:26255 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751130AbWFMOHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:07:48 -0400
Date: Tue, 13 Jun 2006 10:07:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Sridhar Samudrala <sri@us.ibm.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] update sunrpc to use in-kernel sockets API
In-Reply-To: <448E42AE.1010901@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0606131006250.3553@d.namei>
References: <1150156564.19929.33.camel@w-sridhar2.beaverton.ibm.com>
 <Pine.LNX.4.64.0606122320010.31627@d.namei> <448E42AE.1010901@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Sridhar Samudrala wrote:

> > > -	sendpage = sock->ops->sendpage ? : sock_no_sendpage;
> > > +	sendpage = kernel_sendpage ? : sock_no_sendpage;
> > >     
> > 
> > This is not equivalent.
> > 
> >   
> Actually, we could make this a simple assignment as we check for
> sock->ops->sendpage in
> kernel_sendpage().
>    sendpage = kernel_sendpage;

No, the code there is setting different values for sendpage depending on 
whether the page is in high memory or not.


- James
-- 
James Morris
<jmorris@namei.org>
