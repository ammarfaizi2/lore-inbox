Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWHCREp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWHCREp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWHCREo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:04:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:53467 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932576AbWHCREo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:04:44 -0400
Message-ID: <44D22CA4.5090405@us.ibm.com>
Date: Thu, 03 Aug 2006 10:04:36 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take3 2/4] kevent: AIO, aio_sendfile() implementation.
References: <11545983603452@2ka.mipt.ru>
In-Reply-To: <11545983603452@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> AIO, aio_sendfile() implementation.
>
> This patch includes asynchronous propagation of file's data into VFS
> cache and aio_sendfile() implementation.
> Network aio_sendfile() works lazily - it asynchronously populates pages
> into the VFS cache (which can be used for various tricks with adaptive
> readahead) and then uses usual ->sendfile() callback.
>
> ...
> --- /dev/null
> +++ b/kernel/kevent/kevent_aio.c
> @@ -0,0 +1,584 @@
> +/*
> + * 	kevent_aio.c
> + * 
>   
Since this is *almost* same as mpage.c code, wondering if its possible 
to make common
generic/helper routines in mpage.c and use it here ?

Thanks,
Badari

