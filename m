Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289077AbSAGCOb>; Sun, 6 Jan 2002 21:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289083AbSAGCOV>; Sun, 6 Jan 2002 21:14:21 -0500
Received: from sm14.texas.rr.com ([24.93.35.41]:19940 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S289077AbSAGCOH>;
	Sun, 6 Jan 2002 21:14:07 -0500
Message-Id: <200201070215.g072F0u3010729@sm14.texas.rr.com>
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Date: Sun, 6 Jan 2002 20:18:33 -0600
X-Mailer: KMail [version 1.3.1]
Cc: Benjamin LaHaise <bcrl@redhat.com>, Gerrit Huizenga <gerrit@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        Harald Holzer <harald.holzer@eunet.at>, linux-kernel@vger.kernel.org
In-Reply-To: <20020106032030.A27926@redhat.com> <E16NFxv-0005e4-00@the-village.bc.nu> <20020106233726.GA26491@weta.f00f.org>
In-Reply-To: <20020106233726.GA26491@weta.f00f.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If someone has a minute or so, can someone briefly explain the
> difference(s) between PSE and PAE?
>

Here's my (probably simple minded) understanding. With the PSE bit turned on 
in one of the x86 control registers (cr3?), page sizes are 4MB instead of the 
usual 4KB. One advantage of large pages is that there are fewer page tables 
and struct page's to store.

PAE is turned on by setting a different bit. It allows for the possibility up 
to 64GB of physical ram on i686. Actual addresses are still just 32 bits, 
however,  so any given process is limited to 4GB (actually Linux puts a limit 
of 3GB). But by using a 3 level paging scheme it's possible to map process 
A's 32 bit address space to a different region of physical ram than process 
B's which, in turn, is mapped to a different physical region than process C, 
etc. 

As far as I know, it's possible to set both bits simultaneously.

-Marvin

