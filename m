Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031212AbWLAPqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031212AbWLAPqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030903AbWLAPqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:46:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:45990 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S967549AbWLAPqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:46:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UDRvCOS2gSlsUmQzic3+IkPn8ENnyqyENtYlxDubNbRGYnJ1lfukmxqN6SHWdPwXIEaoJMf5R/BXWSh7nnrn2uyqjnn50LLVaJdY27sarj1/uy5Ma00IlI2Ha2leVoGEGB1ZnSa39fTwwZQUvUyyHR4tr4NHSFII/Me8jH4f4WQ=
Message-ID: <3f250c710612010746y717fa46fof4d887c02a1b345d@mail.gmail.com>
Date: Fri, 1 Dec 2006 11:46:45 -0400
From: "Mauricio Lin" <mauriciolin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19] kobject: kobject_uevent() returns manageable value
Cc: "Mauricio Lin" <mauricio.lin@indt.org.br>, linux-kernel@vger.kernel.org,
       greg@kroah.com, Ilias.biris@indt.org.br
In-Reply-To: <20061130230812.dad6b0b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <456F4607.3000300@indt.org.br>
	 <20061130230812.dad6b0b2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 12/1/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 30 Nov 2006 16:58:47 -0400
> Mauricio Lin <mauricio.lin@indt.org.br> wrote:
>
> > Since kobject_uevent() function does not return an integer value to
> > indicate if its operation was completed with success or not, it is
> > worth changing it in order to report a proper status (success or
> > error) instead of returning void.
> >
> > Keep kobject_uevent() returning the status as integer provide a easier
> > way for detecting possible failure in the function. Using void
> > returning style may take people to waste more time to figure out if
> > the "send to" or "receive from" an event is a bug in the kernel or
> > user space. Furthermore, the current way to detect where the error is
> > taking place in the kobject_uevent() requires additional inclusion of
> > printk() in each "if" condition that can lead to failure.
>
> Admirable idea, but we have large changes pending against that code
> and none of this patch applies.

I have used the kobject_uevent() to send event to user space, but when
the event does not happen I have to figure out if this problem is
related to kernel or user space code. After mentioning this issue with
Greg KH, he recommended to provide a patch to fix it.

>
> A patch against Greg's driver tree, or against latest -mm would suit, thanks.

OK. That's good. Thanks.

BR,

Mauricio Lin.
