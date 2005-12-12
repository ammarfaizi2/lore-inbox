Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVLLMoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVLLMoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLLMoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:44:10 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:35019 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751147AbVLLMoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:44:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ReLN+XuuzsdFiTEOsqTPLJ/mxA9BB4f16f6ttdjec9r8Rr/arCaeSwq48yIzZUpvoysbzAdOM4UT1U2DyVgTXOlX1WwPQvd9okJRXpCTUKI6crYFQFNXOJL4qCAk+OAWWEmct38OyCm2JyxDaWYVNNlYmjIZL8Z+hCuaWLkQFQ8=
Message-ID: <81083a450512120444v56038320k6feffa34257a933d@mail.gmail.com>
Date: Mon, 12 Dec 2005 18:14:08 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, rth@redhat.com,
       akpm@osdl.org, Greg KH <greg@kroah.com>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: anandhkrishnan@yahoo.co.in
In-Reply-To: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the correct email id of Anand Krishnan
Signed-off-by: Anand Krishnan <anandhkrishnan@yahoo.co.in>

On 12/12/05, Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
> This patch is the next logical step after the following two  threads
>
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0511.2/2505.html
> http://www.ussg.iu.edu/hypermail/linux/kernel/0511.3/0036.html
>
> When a symbol is exported from the kernel, and say, a module would
> export the same symbol, there currently exists no mechanism to prevent
> the module from exporting this symbol. The module would still go ahead
> and export the symbol, the symbol table would now contain two copies
> of the exported symbol, and hell would break loose.
>
> This patch prevents that from happening, by checking the symbol table
> before relocation for all occurences of the Exported Symbol. If the
> symbol already exists, we branch out with -ENOEXEC. Currently, this
> search is sequential.
>
>
> Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>
> Signed-off-by: Anand Krishnan <anandhkrishnan@yahoo.com>
>
>
>
