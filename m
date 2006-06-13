Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWFMLNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWFMLNs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 07:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWFMLNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 07:13:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:36075 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750952AbWFMLNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 07:13:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MW1a+gnUMSrHfvKyTwoVB6kFICTOcFxGITf82MfCVdQK0ODhST/4XtnrttGMUS5oiAbN+fUXiryJ1qRnkCndHdsnrcLYw8/BIHTnqYRa2/JAsJmb/n/KrVOMYj1fXglFzjviVQgqDpe1N/sBcIH7YsX5bbwWP5qVzA9UmGbyD9E=
Message-ID: <39e6f6c70606130413g555c501fra845075833c3336b@mail.gmail.com>
Date: Tue, 13 Jun 2006 08:13:42 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "Stephen Hemminger" <shemminger@osdl.org>
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Cc: "Sridhar Samudrala" <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060613140716.6af45bec@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com>
	 <20060613140716.6af45bec@localhost.localdomain>
X-Google-Sender-Auth: 963823ce3b7ea94c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/06, Stephen Hemminger <shemminger@osdl.org> wrote:
> On Mon, 12 Jun 2006 16:56:01 -0700
> Sridhar Samudrala <sri@us.ibm.com> wrote:
>
> > This patch makes it convenient to use the sockets API by the in-kernel
> > users like sunrpc, cifs & ocfs2 etc and any future users.
> > Currently they get to this API by directly accesing the function pointers
> > in the sock structure.
> >
> > Most of these functions are pretty simple and can be made inline and moved
> > to linux/net.h.
>
> ...
>
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

I guess so, Sridhar, could you take this into account and resend?

Thanks,

- Arnaldo
