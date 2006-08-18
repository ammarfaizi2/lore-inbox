Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWHRJfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWHRJfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWHRJfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:35:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:30441 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751324AbWHRJfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:35:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EhMhx487RUiPo1J80/Gfyahu1SdZa3svdtvLBXOfHWswLyQD7JXf7bgDaqdiCxZUZunknJnEri1ArS66TQu5A7TSv+YtEr6OzfKlmnexlo0UGBpjVbjtG8yPv6+tOCfPdeiMpFDMyQgMT0DhrWnGv7DdNrYIZ9r2145HD6Y3kzo=
Message-ID: <215036450608180235l28836e3fpa2b529d7c0f69571@mail.gmail.com>
Date: Fri, 18 Aug 2006 17:35:45 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take10 1/2] kevent: Core files.
Cc: lkml <linux-kernel@vger.kernel.org>, "David Miller" <davem@davemloft.net>,
       "Ulrich Drepper" <drepper@redhat.com>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>
In-Reply-To: <11557316932803@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11557316922047@2ka.mipt.ru> <11557316932803@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int __devinit kevent_user_init(void)
> +{
> +       int err = 0;
> +
> +       err = kevent_sys_init();
> +       if (err)
> +               panic("%s: failed to initialize kevent: err=%d.\n", err);

Here should be?
                    panic("%s: failed to initialize kevent: err=%d\n",
kevent_name, err);
