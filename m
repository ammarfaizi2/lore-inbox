Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbRF1Oss>; Thu, 28 Jun 2001 10:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265976AbRF1Osj>; Thu, 28 Jun 2001 10:48:39 -0400
Received: from mailout4-0.nyroc.rr.com ([24.92.226.120]:23696 "EHLO
	mailout4-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S265972AbRF1Os2>; Thu, 28 Jun 2001 10:48:28 -0400
Message-ID: <00b101c0ffe2$fb77ad30$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "John Fremlin" <vii@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.d69j5vv.ej8irj@ifi.uio.no> <fa.h2rpibv.87m5bp@ifi.uio.no>
Subject: Re: A signal fairy tale
Date: Thu, 28 Jun 2001 10:59:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Signals are a pretty dopey API anyway - so instead of trying to patch
> them up, why not think of something better for AIO?

I have to agree, in a way... At some point we need to swallow our pride,
admit that UNIX has a crappy event model, and implement something like Win32
GetMessage =)...

I've been having trouble finding situations where asynchronous signals are
really the most appropriate technique, aside from delivering
life-threatening things like SIGTERM, SIGKILL, and SIGSEGV. The mutation
into queued, information-carrying siginfo signals just shows how badly we
need a more robust event model... (what would truly kick butt is a unified
interface that could deliver everything from fd events to AIO completions to
semaphore/msgqueue events, etc, with explicit binding between event queues
and threads).

Regards,
Dan

