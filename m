Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289116AbSAGEkh>; Sun, 6 Jan 2002 23:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289117AbSAGEk1>; Sun, 6 Jan 2002 23:40:27 -0500
Received: from oe64.law9.hotmail.com ([64.4.8.199]:16132 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S289116AbSAGEkN>;
	Sun, 6 Jan 2002 23:40:13 -0500
X-Originating-IP: [66.108.21.174]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Chris Wedgwood" <cw@f00f.org>
In-Reply-To: <20020106032030.A27926@redhat.com> <E16NFxv-0005e4-00@the-village.bc.nu> <20020106233726.GA26491@weta.f00f.org> <200201070215.g072F0u3010729@sm14.texas.rr.com> <20020107023854.GA26751@weta.f00f.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Sun, 6 Jan 2002 23:40:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE64O554Q0BUHaxrXcq0000d9af@hotmail.com>
X-OriginalArrivalTime: 07 Jan 2002 04:40:08.0302 (UTC) FILETIME=[626658E0:01C19735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    There are 2MB pages as well.  Probably would be a better choice than
4MB.  Also only has a 2 tier paging mechanism instead of a 3 tier one when
paging with 4KB which should help take care of the current slowdown with
highmem.

----- Original Message -----
From: "Chris Wedgwood" <cw@f00f.org>
To: "Marvin Justice" <mjustice@austin.rr.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Benjamin LaHaise"
<bcrl@redhat.com>; "Gerrit Huizenga" <gerrit@us.ibm.com>; "M. Edward
Borasky" <znmeb@aracnet.com>; "Harald Holzer" <harald.holzer@eunet.at>;
<linux-kernel@vger.kernel.org>
Sent: Sunday, January 06, 2002 9:38 PM
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?


> On Sun, Jan 06, 2002 at 08:18:33PM -0600, Marvin Justice wrote:
>
>     Here's my (probably simple minded) understanding. With the PSE bit
>     turned on in one of the x86 control registers (cr3?), page sizes
>     are 4MB instead of the usual 4KB. One advantage of large pages is
>     that there are fewer page tables and struct page's to store.
>
> Ah, I knew 4MB pages were possible... I was under the impression _all_
> pages had to be 4MB which would seem to suck badly as they would be
> too coarse for many applications (but for certain large sci. apps. I'm
> sure this would be perfect, less TLB thrashing too with sparse
> data-sets).
>
> On the whole, I'm not sure I can see how 4MB pages _everywhere_ in
> user-space would be a win for many people at all...
>
>
>   --cw
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
