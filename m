Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVIFGrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVIFGrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVIFGrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:47:45 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:29378 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932423AbVIFGrp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:47:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rjpjj8E2kHPXoQ/HslPcAotPxtxSwAZ3tBpfxU+WMgq0yL3xqt1Cb5sONvKi/jfWdaafdpM0kZgtp3fbqqCSpwOIQPKH3RAWbMdFnPnjUqM7DtSrQ5ob+qkWjQ1C3ltSVYc+DFhSWf7BBIrMP1beAWFqeSuyOPgFYqXEfCtX6U4=
Message-ID: <e8ac1af105090523472d2af8a7@mail.gmail.com>
Date: Tue, 6 Sep 2005 12:17:40 +0530
From: Tushar Adeshara <adesharatushar@gmail.com>
To: mandy london <laborious.bee@gmail.com>
Subject: Re: the difference between irq save and the irq disable ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <907421f905090506337ba17394@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <907421f905090506337ba17394@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, mandy london <laborious.bee@gmail.com> wrote:
> in my mind, irq save only store the conditions of that time ,  and the
> following code can access the shared region and change it ,so modify
> irq  states .
> 
> while , disable irq  keeps the states of interrupt unchangable .
> 
> but , I have no knowlege of the difference between code in irq save
> and irq restore and  in irq disable and irq enable ?
> 
> whethe the former can be interrupted and the later not ? only this ?

Have a look at Documentaion/cli-sti-removal.txt. As per that,
irq_enable will enable all irqs and irq_restore will bring irq status
to the one it was
before irq_save.
                            And as per my knowledge, non are
interruptible except case of RT.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Regards,
Tushar
--------------------
It's not a problem, it's an opportunity for improvement. Lets improve.
