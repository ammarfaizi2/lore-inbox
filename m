Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSE3OU2>; Thu, 30 May 2002 10:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSE3OU1>; Thu, 30 May 2002 10:20:27 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25605 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316664AbSE3OU0>; Thu, 30 May 2002 10:20:26 -0400
Message-Id: <200205301417.g4UEH2Y32073@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Urban Widmark <urban@teststation.com>, Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Processes stuck in D state with autofs + smbfs
Date: Thu, 30 May 2002 17:18:46 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205301421540.1921-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2002 10:36, Urban Widmark wrote:
> > I also have this in my kernel log:
> > May 26 06:33:16 fileserver kernel: Uhhuh. NMI received. Dazed and
> > confused, but trying to continue May 26 06:33:16 fileserver kernel: You
> > probably have a hardware problem with your RAM chips
>
> However, this error could (but I don't really know what the effects are of
> this) potentially stop a process at some random point. If a process
> crashes, for example an oops, while holding the semaphore that semaphore
> will still be held and everyone trying to get in will stop in D state.

AFAIK this message says CPU got a spurious NMI. It does not kill the task,
kernel logs this message and returns from NMI interrupt handler.

What does cat /proc/interrupts tell you?

NMI may be truly spurious or a hardware failure indication. Give your box
an overnight run of memtest86.
--
vda
