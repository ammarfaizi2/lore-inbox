Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWJPJf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWJPJf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWJPJf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:35:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:55415 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030317AbWJPJfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:35:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nKKm5aJgn6/qDi60b2RBlD9WoWm8Qlc9FJCh9wWgxoIeBsNAosO1b9pXJdaF/8zDWAxMxoVHmcVNa9D/cGihTLgYCmMEiruPgfH4IO+tKUB9gJxfgnLfUfnQz0x0rCfpVTtNLXwRxvTdccAf6yclRQ5qn90sX+YDp5IPd9wJJ+U=
Message-ID: <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
Date: Mon, 16 Oct 2006 18:35:24 +0900
From: "Mohit Katiyar" <katiyar.mohit@gmail.com>
To: "Frank van Maarseveen" <frankvm@frankvm.com>
Subject: Re: NFS inconsistent behaviour
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061016084656.GA13292@janus>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
	 <20061016084656.GA13292@janus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
But I think unmounting will free the sockets. I am also unmounting the
partition in the loop. Also both machines are same configuration but
show different behaviour.

Thanks
Mohit

On 10/16/06, Frank van Maarseveen <frankvm@frankvm.com> wrote:
> On Mon, Oct 16, 2006 at 04:13:00PM +0900, Mohit Katiyar wrote:
> [...]
> >
> > [Machine1:] while :; do mount -a -F -t nfs ;umount -a -t nfs ; done
> >
>
> This will quickly run out of [privileged] TCP sockets unless mount and
> nfs use UDP.
>
> Try mounting with -o udp
>
> --
> Frank
>
