Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284860AbSABV7Y>; Wed, 2 Jan 2002 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbSABV7P>; Wed, 2 Jan 2002 16:59:15 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:50099 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284860AbSABV7H>; Wed, 2 Jan 2002 16:59:07 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: "ChristianK."@t-online.de (Christian Koenig)
To: timothy.covell@ashavan.org, linux-kernel@vger.kernel.org
Subject: Re: How can one get System.map w/o vmlinux?
Date: Wed, 2 Jan 2002 23:00:56 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <200201021951.g02JpCSr021687@svr3.applink.net>
In-Reply-To: <200201021951.g02JpCSr021687@svr3.applink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <16LtPN-0e5I1YC@fwd07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 02 January 2002 20:47, Timothy Covell wrote:
> The System.map question brings up several more:
>
> 1. Is it correct to say that System.map is basically
> the software interrupt table? ( and that for Linux
> software Interrupts equal syscalls)

Nope, software interrupts sound more like the interface 
user -> kernel, but System.map additionaly containing
Kernel only symbols, who are not accessible directly with syscals 
(but may be used by them).

> 2. If one doesn't have vmlinux lying around, is there
> an easy way to recreate this (via a syscall or small
> SUID root C program to dump out the vectors)

cat /proc/ksyms | grep -v "^c8" | sort 
gives a subset off System.map (the Symbols exported for module use).

MfG,Christian König.
