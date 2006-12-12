Return-Path: <linux-kernel-owner+w=401wt.eu-S1751473AbWLLQsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWLLQsP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWLLQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:48:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:32915 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbWLLQsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:48:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l34M811ZnO5t7q5l5s2RFUkXd0nl4jl90X1UnUYj8dQpwUDtdFro50HRie2dXGJqrynea06hg+foAEO21Sj0fiPrYEpL/WX72qLZD2AENXcO4tcODLIDNvObGEY4aPlLv38IXfD9v8miHpFAn+NDp7F0YdgXKjapnWrC94Z08lE=
Message-ID: <aa5953d60612120848y47ad5365x5e5acf9d1839a7d@mail.gmail.com>
Date: Tue, 12 Dec 2006 22:18:12 +0530
From: "Jaswinder Singh" <jaswinderrajput@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Support 2.4 modules features in 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1165937853.27217.625.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aa5953d60612120606g8c59542seaa440b7b0404ff5@mail.gmail.com>
	 <1165932674.27217.608.camel@laptopd505.fenrus.org>
	 <aa5953d60612120711h375eecadpeb20d971853626cc@mail.gmail.com>
	 <1165937853.27217.625.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-12-12 at 20:41 +0530, Jaswinder Singh wrote:
> > On 12/12/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Tue, 2006-12-12 at 19:36 +0530, Jaswinder Singh wrote:
> > > > Hello,
> > > >
> > > > I want to support old 2.4 modules features in 2.6 kernel modules:-
> > > > 1. no kernel source tree is required to build modules.
> > >
> > > this is a 2.6 not a 2.4 feature btw
> > >
> >
> > Really!! , Please let me know what is the procedure to build the
> > modules after deleting kernel linux-2.6*
>
> you only need include/* for this in 2.6
>
> you can't do this at all with 2.4 kernels, it needs the whole lot.
>
> (in both cases the code and headers are needed so that your module can
> use the data structures and compile in the kernel code you select to use
> from inlines)
> >
> >

Really!!

This is my Makefile :-
obj-m += hello-1.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean


Now do one thing:-
# mv /lib/modules/$(uname -r)/build /lib/modules/$(uname -r)/build0

now make it.

If you want point to your header files in /usr/include and then try to build.

Regards,

Jaswinder Singh.
