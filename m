Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWCLJZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWCLJZN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 04:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWCLJZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 04:25:13 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:30119 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751268AbWCLJZL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 04:25:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlfcN8Vu1741o4Q/WWFlaCrAVBgBQebHGGNpVxefVwSiIWrfisEJ/QNA4mlbkbq0TJ6nyoQEevz+CywZlrNGHz/hm9FDLkaidtNR8ak9KsivE3J0Zvb48Py6ZqsyhXZGbjXQUAw7PCN28i+kH45xVtueIyb4Wb7RNY6geb3P0Ms=
Message-ID: <60bb95410603120125n24c3a283xe1fabeb255c8c59b@mail.gmail.com>
Date: Sun, 12 Mar 2006 17:25:11 +0800
From: "James Yu" <cyu021@gmail.com>
To: "Willy Tarreau" <willy@w.ods.org>
Subject: Re: weird behavior from kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060312084632.GB21493@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <60bb95410603111923icba8adeid90c1dfa94f2e566@mail.gmail.com>
	 <20060312084632.GB21493@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The major reason to choose 2.4.18 as my dev base is that the dev is
ment to be carried out on a custom ARM board, and there isn't any
2.6's port available.

I'll try that "-fno-strength-reduce" option and see how it goes.
More comments are welcome.
cheers,

On 3/12/06, Willy Tarreau <willy@w.ods.org> wrote:
> It might be a wrong gcc optimization which generates bad code. If you're
> working on such an old kernel (about 5 years old), maybe you're using
> and old, broken compiler too ? gcc-2.95[.1], gcc-2.96, 3.0 and 3.1 have
> been known to produce bad code for a long time. Also ensure that you
> pass the "-fno-strength-reduce" option to gcc.
>
> Anyway, if you're starting a new dev, I would suggest using a more
> recent kernel : 2.6.1[56] or 2.4.32 if you need 2.4.
>
> regards,
> Willy
>
>


--
James
cyu021@gmail.com
