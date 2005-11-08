Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbVKHWhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbVKHWhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbVKHWhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:37:50 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:16101 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030381AbVKHWht convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:37:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ma4xGe+8f6kfM6/YShojd7YcsExnwfvhTQMWBbHctcyfUu9FFzQNJlBHzPinl2u+Xu1cud8kTasUmVCoDM+SbiJ1xqjkod/lyhTROk0yp3yI92obiWd5aDdqofAzSaIO5GWVerYLomQ9vQDMWJf1VKwaxoq5bdwOzR6x3/8O4ao=
Message-ID: <fb7befa20511081437p3355ba0aic8c9c518d3cc7b19@mail.gmail.com>
Date: Tue, 8 Nov 2005 17:37:46 -0500
From: Adayadil Thomas <adayadil.thomas@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Creating new System.map with modules symbol info
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511081712210.6019@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
	 <1131487518.2789.26.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0511081712210.6019@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to use lcrash to debug a panic

I have the System.map of the original kernel (without modules loaded),
Kerntypes file and the dump file

    <4>Modules linked in: ip_conntrack_dos
    <4>CPU:    0
    <4>EIP:    0060:[<f8bb245b>]    Tainted: P      VLI
    <4>EFLAGS: 00010246   (2.6.12)
    <4>EIP is at init_conntrack_syn+0x193/0x214 [ip_conntrack_dos]
    <4>eax: dd0f34b3   ebx: f48de908   ecx: f48de900   edx: 00000000
    <4>esi: f4c65bc8   edi: f48de900   ebp: 00100100   esp: c040dae0
    <4>ds: 007b   es: 007b   ss: 0068


If i Use the original System.map, it doesnt find the symbol for the
init_conntrack_syn
( EIP is pointing there)
However, kallsyms has an entry for that
f8b752c8 t init_conntrack_syn

If kallsyms has all the symbols, I am wondering why does it have lesser lines ?

wc -l
12343 kallsyms
32127 System.map

Will it work if I cat System.map and kallsyms together and do a sort and uniq
so that i get the union of both ?



On 11/8/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Tue, 8 Nov 2005, Arjan van de Ven wrote:
>
> > On Tue, 2005-11-08 at 16:04 -0500, Adayadil Thomas wrote:
> >> Greetings.
> >>
> >> The System map that was created when compiling kernel does'nt have the symbols
> >> of modules that are loaded later. How can I create a new System.map
> >> with the symbols of
> >> modules also.
> >
> > maybe a silly question.. but why does it matter? Eg what tool uses this
> > info?
>
> Maybe he's creating a tool. Anyway /proc/kallsyms will have all
> the symbols and their offsets of the currently running kernel.
> It's a good way to find offsets of items not currently exported.
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
>
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
> Thank you.
>
