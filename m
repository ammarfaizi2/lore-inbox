Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265485AbSIRGpX>; Wed, 18 Sep 2002 02:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSIRGpX>; Wed, 18 Sep 2002 02:45:23 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:16141 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265485AbSIRGpV>; Wed, 18 Sep 2002 02:45:21 -0400
Message-Id: <200209180643.g8I6hBp29508@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hardware limits on numbers of threads?
Date: Wed, 18 Sep 2002 09:37:58 -0200
X-Mailer: KMail [version 1.3.2]
References: <3D88208E.8545AAA2@kegel.com>
In-Reply-To: <3D88208E.8545AAA2@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 September 2002 04:43, Dan Kegel wrote:
> http://people.redhat.com/drepper/glibcthreads.html says:
> > Hardware restrictions put hard limits on the number of
> > threads the kernel can support for each process.
> > Specifically this applies to IA-32 (and AMD x86_64) where the thread
> > register is a segment register. The processor architecture
> > puts an upper limit on the number of segment register values
> > which can be used (8192 in this case).
>
> Is this true?  Where does the limit come from?

It is true that on x86 you have only 8192 different segment selectors
at a time. Nobody says you can't modify segment descriptors on demand.

If I'm not mistaken, Linux kernel does precisely this. It has per-CPU
allocated GDT entries, not per-task. So there is no limitation
unless you happen to have more than 1024 CPUs ;-).
--
vda
