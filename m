Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWAJKtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWAJKtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJKtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:49:35 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:4106 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932128AbWAJKtf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:49:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b4pIuybEYiKwdkS5YesrLWzslX1OGQ9JFFPDjYtKTdL1wPCoNvNf7YOWL4M6hjBUX/OJxpmusEF831SH7CMkes9datIZtRawGEXcox6a4UOxcaHE36EYXDyxWHP2oN1LJU1xbI1UdkDDl3qepNfA9C2csZxvK53G+ak8WD73HjY=
Message-ID: <f0309ff0601100249y4ffa3596sa2a623015cdca66b@mail.gmail.com>
Date: Tue, 10 Jan 2006 02:49:34 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: X86_64 and X86_32 bit performance difference [Revisited]
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.kernel.org
In-Reply-To: <1136793080.2936.14.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f0309ff0601082229u3fc5e415m12be9dc921f4a099@mail.gmail.com>
	 <1136793080.2936.14.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sun, 2006-01-08 at 22:29 -0800, Nauman Tahir wrote:
> > Hello All
> > I have posted this problem before. Now mailing again after testing as
> > recommeded in previous replys.
> > My configuration is:
> >
> > Hardware:
> > HP Proliant DL145 (2 x AMD Optaron 144)
> > 14 GB RAM
> >
> > OS:
> > FC 4
> >
> > Kernel
> > 2.6.xx
>
> You *STILL* have not posted the URL to your source code.
> How is anyone supposed to help you without that?????

I have attached a file which I use as thread API. Complete code is
quiet large and also need proper description. which i would be posting
if needed.
I hope I make my problem clear: I repeat : same code is giving alot of
performance degradation on previously mentioned configuration. One
suspect is the thread library.


dts_thread_t *dts_register_thread(void (*run) (void *),  const char
*name, void * private)

is the function to register my thread handler

void dts_wakeup_thread(dts_thread_t *thread)

is the function in the dts_thread.c which i use to run my thread.

all my thread handlers either
call generic_make_request some times for my RAMDISK and sometimes for
my Target device [SCSI DISK or local HDD partition]
OR
uses list.h



>
>
>
>
>
