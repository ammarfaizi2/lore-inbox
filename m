Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422926AbWJYECJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWJYECJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 00:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWJYECJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 00:02:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:56259 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161338AbWJYECG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 00:02:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bVNTKrA6xHLNXeWMo7zlTPclXV3PqagHKdfsuop6Eu0f+wWU6i42HQpNxUzUvOXlvgg3W32DTzL87CbqbSupvKNrFfR2ZmbJVmRMnlt+hKLYf6PjnKpWiCsD63uQWbGMQMZWxrhO7Gf9Q7DdkSk/YzZq6CLopvCisO1ZZ61drY0=
Message-ID: <86802c440610242102h8627eb5xd0f62bb0310ecd17@mail.gmail.com>
Date: Tue, 24 Oct 2006 21:02:05 -0700
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>, "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com>
	 <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
X-Google-Sender-Auth: 8b33c82995bd6b93
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

This could get into your tree.

YH

On 10/24/06, Yinghai Lu <yinghai.lu@amd.com> wrote:
> resend with gmail.
>
> Clear the irq releated entries in irq_vector, irq_domain and vector_irq
> instead of clearing irq_vector only. So when new irq is created, it
> could reuse that vector. (actually is the second loop scanning from
> FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
> with enough module inserting and removing
>
> Cc: Eric W. Biedierman <ebiederm@xmission.com>
> Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>
>
>
>
