Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWILChz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWILChz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 22:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965255AbWILChz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 22:37:55 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:63066 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965133AbWILChy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 22:37:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Du93Rqdz5+57o/f6GsvSWJeGoKKAzOhXEVhVSUqDXDeRNXcCSTf+xkI8duyKTgZVxkGSjO64h9Ffuyx8h6GCBxdqE8wU4xaamL+kgERDMgfV0WkTT1XcaRMnfUinBDXM+WvW+ypExb2LhqDk2mNiAVbbcZvIJMTw9wNUuCOsTTs=
Message-ID: <653402b90609111937i1d986331kc5ed167cb08831b7@mail.gmail.com>
Date: Tue, 12 Sep 2006 04:37:53 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: [PATCH 2/2] display: Driver ks0108 and cfag12864b
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060912011346.GB5192@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90609111627q661cded8l757129311fbe92d4@mail.gmail.com>
	 <653402b90609111657r1fa861e0gf4d71508df60a5ec@mail.gmail.com>
	 <20060912011346.GB5192@martell.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> arrrrggg....  I'm in the middle of reading every module_init and every
> module_exit func, and this starts getting really annoying....
>

Anyway, thank you for you time reviewing it. :)


>         5. In case of error during initialization, error code SHOULD be
>            propagated as is to upper layers, either via direct
>            assignment/return or via decoding from pointer.
>

What do you mean? I thought returning the error code was enough.


>         6. Error messages SHOULD start with short unique prefix specific to
>            driver. Module name without .o and .ko is fine.

They do 8)

#define PRINTK_PREFIX PRINTK_INFO NAME ": "

printk(PRINTK_PREFIX "Init... ");

Then, if a error appears: printk("ERROR - kmalloc\n");

Final string: "<i>cfag12864b: Init... ERROR - kmalloc"

The only bad point: If some other printk is called from other module
between. Should I change it?


    Miguel Ojeda
