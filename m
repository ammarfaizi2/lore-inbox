Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWFBHOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWFBHOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWFBHOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:14:22 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:2489 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1751246AbWFBHOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:14:21 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.0.166):SA:0(-102.3/1.7):. Processed in 3.16553 secs Process 10192)
From: "Abu M. Muttalib" <abum@aftek.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       "Paulo Marques" <pmarques@grupopie.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Page Allocation Failure, Why?? Bug in kernel??
Date: Fri, 2 Jun 2006 12:51:12 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMEEJNCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <9a8748490606020005n841abafjc7e05a5e2ab8a312@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I repeat my question, the required no of pages are available, as shown in
the dump produced by kernel, the request is not fulfilled. Its as follows:

DMA: 106*4kB 11*8kB 5*16kB 3*32kB 2*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
944kB

Why this is so??

~Abu.

-----Original Message-----
From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
Sent: Friday, June 02, 2006 12:36 PM
To: Abu M. Muttalib
Cc: Martin J. Bligh; Paulo Marques; linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??


On 02/06/06, Abu M. Muttalib <abum@aftek.com> wrote:
> Hi,
>
> That's precisely I want to say. The PAGES are available but they are not
> allocated to process. Why??
>
There may be 32 pages available in total, but not 32 contiguous ones -
that's a *lot* of contiguous pages to ask for in kernel space - 128KB
(assuming a 4096 byte page size).

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

