Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288485AbSAHWGh>; Tue, 8 Jan 2002 17:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSAHWGb>; Tue, 8 Jan 2002 17:06:31 -0500
Received: from mailf.telia.com ([194.22.194.25]:8665 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S288485AbSAHWGW>;
	Tue, 8 Jan 2002 17:06:22 -0500
Message-Id: <200201082203.g08M3dj19629@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@zip.com.au (Andrew Morton)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 8 Jan 2002 23:00:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: phillips@bonn-fries.net (Daniel Phillips),
        anton@samba.org (Anton Blanchard), andrea@suse.de (Andrea Arcangeli),
        kernel@Expansa.sns.it (Luigi Genoni),
        Dieter.Nuetzel@hamburg.de (Dieter N?tzel),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        rml@tech9.net (Robert Love)
In-Reply-To: <E16O2d3-0007VF-00@the-village.bc.nu>
In-Reply-To: <E16O2d3-0007VF-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesdayen den 8 January 2002 21.13, Alan Cox wrote:
> > low-latency kernel".  Now, IF we can come to this decision, then
> > internal preemption is the way to do it.  But it affects ALL kernel
>
> The pre-empt patches just make things much much harder to debug. They
> remove some of the predictability and the normal call chain following
> goes out of the window because you end up seeing crashes in a thread with
> no idea what ran the microsecond before
>
> Some of that happens now but this makes it vastly worse.
>
> The low latency patches don't change the basic predictability and
> debuggability but allow you to hit a 1mS pre-empt target for the general
> case.
>

Yes, it does make things much much harder to debug - but:
* If you get a problem on a preemtive UP kernel, it is likely to be a problem
  on a SMP too - and those are hard to debug aswell. But the positive aspect
  is that you get more people that can do the debugging... :-)
  (One CPU gets delayed with handling a IRQ the other runs into the critical
   section)
* It is optional at compile time.
   And could even be made run time optional / CPU ! Just set a too big value
   on the counter and it will never reschedule...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
