Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVH1G4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVH1G4U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 02:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVH1G4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 02:56:20 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:521 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750916AbVH1G4T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 02:56:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oN6fbYe0BVXOsShYRLfFv3x0djPSPXwzS4TIMLDu/AHWnOt8MK+0Lr8efvZeniQJpAgILnOsxHIcCy3CQ2xHMTMB9A4YhjehEFsEql2XQ9u5mFGoLYYTfVYmHtbISTBLkKOb71g1fHlpcztJqB7KkPJa0vdIrtko2dY+Dn1KC+M=
Message-ID: <1e33f571050827235629b70120@mail.gmail.com>
Date: Sun, 28 Aug 2005 12:26:16 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: lab liscs <liscs.lab@gmail.com>
Subject: Re: when the kernel runs in softirq and tasklet , which context is it in ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1132fcd605082709051c2a7141@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1132fcd605082709051c2a7141@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/05, lab liscs <liscs.lab@gmail.com> wrote:
> I thought it must be in system context ,but always with a litte doubt.
> 
> is there third context the kernel can run in ?
> -

If I am not wrong, softirq runs in process context (system call is
also done through softirq, int 0x80 - this runs in process context),
where as hardware irq and taslets run in no context, i mean no process
context, so we should not use current pointer here.

Please cortrect me if I am wrong.
regards,
-Gaurav

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
