Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316378AbSEOMJy>; Wed, 15 May 2002 08:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316379AbSEOMJx>; Wed, 15 May 2002 08:09:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15364 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316378AbSEOMJw>; Wed, 15 May 2002 08:09:52 -0400
Message-Id: <200205151200.g4FC0MY13196@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC][PATCH] iowait statistics
Date: Wed, 15 May 2002 15:02:57 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com> <3CE073FA.57DAC578@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2002 00:18, Andrew Morton wrote:
> Rik van Riel wrote:
> > 4) on SMP systems the iowait time can be overestimated, no big
> >    deal IMHO but cheap suggestions for improvement are welcome
>
> I suspect that a number of these statistical accounting mechanisms
> are going to break.  The new irq-affinity code works awfully well.
>
> The kernel profiler in 2.5 doesn't work very well at present.
> When investigating this, I ran a busy-wait process.  It attached
> itself to CPU #3 and that CPU received precisely zero interrupts
> across a five minute period.  So the profiler cunningly avoids profiling
> busy CPUs, which is rather counter-productive.  Fortunate that oprofile
> uses NMI.

What, even local APIC interrupts did not happen on CPU#3
in these five mins?
--
vda
