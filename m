Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVEQLuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVEQLuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVEQLql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:46:41 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:13422 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261522AbVEQLob convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:44:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QEuEJbJjfrRdUo/cvVXaoGPTeOTm/U5kpTgPcLQbCl3w4IxVFu/J/7JpP2Pgl9ERyuEEaHHFiINecD0D2NfQUDIda61HZxFQS3CbQMRFTDQV2D1CNCnoqhvmrWZ/1YEbcMjgqIYsSa/CQCgfP4rlORyiPiEVf29Tbkgl7np1k2M=
Message-ID: <b82a8917050517044428d61050@mail.gmail.com>
Date: Tue, 17 May 2005 17:14:26 +0530
From: Niraj kumar <niraj17@gmail.com>
Reply-To: niraj17@iitbombay.org
To: linux <kernel@wired-net.gr>
Subject: Re: 2.6 kernel network programming
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000b01c55ad2$5acaf690$0101010a@dioxide>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703441093903a@mail.gmail.com>
	 <000b01c55ad2$5acaf690$0101010a@dioxide>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, linux <kernel@wired-net.gr> wrote:
> Hi all,
> can someone tell me how i can listen and accept connections into a port from
> the kernel-space???
> I start listening with the following function :
> 
>         struct socket *sock;
>         struct sockaddr_in sin;
>         int error=0;
> 
>         error=sock_create(PF_INET,SOCK_STREAM,IPPROTO_TCP,&sock);
> 
>         sin.sin_family = AF_INET;
>         sin.sin_addr.s_addr = INADDR_ANY;
>         sin.sin_port = htons((unsigned short)port);
> 
>         error=sock->ops->bind(sock,(struct sockaddr*)&sin,sizeof(sin));
>         sock->ops->listen(sock,48);
> 
> How about accepting connections and sending some kind of a message for
> beggining?
> Can someone help me please.

Looking at khttpd code in 2.4 kernel may  help you .

http://lxr.linux.no/source/net/khttpd/sockets.c?v=2.4.28

Regards
Niraj
