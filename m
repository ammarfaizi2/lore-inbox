Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSEaPrO>; Fri, 31 May 2002 11:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSEaPrN>; Fri, 31 May 2002 11:47:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33774 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315445AbSEaPrN>; Fri, 31 May 2002 11:47:13 -0400
Subject: Re: Linux 2.4.19pre9-ac3
From: Robert Love <rml@tech9.net>
To: faisal@q80.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205311637.11160.faisal@q80.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 08:47:11 -0700
Message-Id: <1022860031.985.1294.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-31 at 06:37, Faisal Malallah wrote:
> I got this error while I was compiling 2.4.19-pre9-ac3 + preempt:
>  <snip>

That is a thinko in the preempt patch, not -ac... don't bother Alan with
it.

There is a new version of the patch up at the usual place which is
fixed.  Or in smp.c just replace

	cpu = get_cpu();

with

	preempt_disable();
	cpu = smp_processor_id();

and replace

	put_cpu();

with

	preempt_enable();

Sincerely,

	Robert Love



