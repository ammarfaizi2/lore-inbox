Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSHIRZY>; Fri, 9 Aug 2002 13:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSHIRZY>; Fri, 9 Aug 2002 13:25:24 -0400
Received: from daffy.thegoop.com ([206.58.79.242]:37640 "EHLO
	daffy.thegoop.com") by vger.kernel.org with ESMTP
	id <S314938AbSHIRZX>; Fri, 9 Aug 2002 13:25:23 -0400
Date: Fri, 9 Aug 2002 10:28:32 -0700
From: David Bronaugh <dbronaugh@linuxboxen.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch to enable K6-2 and K6-3 processor optimizations
Message-Id: <20020809102832.05f346a2.dbronaugh@linuxboxen.org>
In-Reply-To: <1028889079.30103.184.camel@irongate.swansea.linux.org.uk>
References: <20020809014840.4e81fbd3.dbronaugh@linuxboxen.org>
	<1028889079.30103.184.camel@irongate.swansea.linux.org.uk>
Organization: Independent
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Aug 2002 11:31:19 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> We can't actually use MMX/FPU instructions in the kernel in the general
> case. That would require saving and restoring the user process floating
> point state - which is extremely expensive

Yes, but that's not all that was implemented here.

>From the GCC 3.1 changelog:

# Prefetch support has been added to the Pentium III, Pentium 4, K6-2, K6-3, and Athlon series.

That's (as I understand it) independent from the floating point instructions.

Also, as a general point (IMO), targeting as specifically as possible (ie, K6-2 or K6-III rather than just K6) will most probably produce the best code for the processor. This also allows for later generations of compilers to make other optimizations and the kernel to take advantage of them.

David Bronaugh
