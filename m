Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbRE1Wm6>; Mon, 28 May 2001 18:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbRE1Wms>; Mon, 28 May 2001 18:42:48 -0400
Received: from ppp21-net1-idf2-bas1.isdnet.net ([195.154.50.21]:59915 "EHLO
	LAP") by vger.kernel.org with ESMTP id <S261369AbRE1Wmf>;
	Mon, 28 May 2001 18:42:35 -0400
Message-ID: <009601c0e7c5$bd7021f0$0101a8c0@LAP>
From: "Vadim Lebedev" <vlebedev@aplio.fr>
To: "Kurt Roeckx" <Q@ping.be>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529002900.A3190@ping.be>
Subject: Re: Potenitial security hole in the kernel
Date: Tue, 29 May 2001 00:30:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-OriginalArrivalTime: 28 May 2001 22:30:03.0919 (UTC) FILETIME=[BD7021F0:01C0E7C5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt,

Maybe i'm missing something but it seems that during execution of the signal
handler, user mode stack contains kernel mode context...
Hence the security hole

Vadim

----- Original Message -----
From: "Kurt Roeckx" <Q@ping.be>
To: "Vadim Lebedev" <vlebedev@aplio.fr>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 29, 2001 12:29 AM
Subject: Re: Potenitial security hole in the kernel


> On Mon, May 28, 2001 at 11:43:38PM +0200, Vadim Lebedev wrote:
> > Hi folks,
> >
> > Please correct me if i'm wrong but it seems to me that i've stumbled on
> > really BIG security hole in the signal handling code.
> > The problem IMO is that the signal handling code stores a processor
context
> > on the user-mode stack frame which is active while
>
> And how is that different from any other function call?
>
>
> Kurt
>
>

