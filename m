Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290243AbSAXDsg>; Wed, 23 Jan 2002 22:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290244AbSAXDsY>; Wed, 23 Jan 2002 22:48:24 -0500
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:1724 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S290243AbSAXDsS>; Wed, 23 Jan 2002 22:48:18 -0500
Message-ID: <036a01c1a48a$0480da40$1d01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.h7o6q7v.lha792@ifi.uio.no> <fa.divhjuv.3guviq@ifi.uio.no>
Subject: Re: Low latency for recent kernels
Date: Wed, 23 Jan 2002 22:48:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a little surprised that desktop users do notice significant
> benefits with all the latency/preempt patches.  If you actually
> instrument the kernel's behaviour, the stalls are in fact
> quite small and infrequent.

Havoc Pennington, Soeren Sandmann, and I have been investigating causes of
UI unresponsiveness in Xfree86/Linux. I would agree that in most situations,
on a mostly-idle machine, low-latency/preempt patches should *not* enhance
the overall feel of the desktop. (if they do measurably increase
responsiveness, then that would suggest inefficiencies in X/the WM/the X
client - a definite possibility, of course).

Two situations where I would expect low-latency/preemption to have a
positive effect on responsiveness are 1) when the system is under heavy CPU
and disk load (e.g. kernel compile); due to the interactive tasks being able
to run earlier/more often, and 2) when performing UI operations that depend
on tight synchronization between X/the WM/the X client, particularly opaque
window resizing. (my theory is that low-latency/preemption results in the
CPU switching more rapidly or evenly among these processes, reducing the
perceptible "lag" between the client window and its WM frame)

Regards,
Dan

