Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSJLXxR>; Sat, 12 Oct 2002 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261379AbSJLXxR>; Sat, 12 Oct 2002 19:53:17 -0400
Received: from AMarseille-201-1-3-116.abo.wanadoo.fr ([193.253.250.116]:10608
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261377AbSJLXxR>; Sat, 12 Oct 2002 19:53:17 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Zapp Foster" <zzaappp@yahoo.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Performance improvement inquiry
Date: Sun, 13 Oct 2002 01:58:49 +0200
Message-Id: <20021012235849.21437@192.168.4.1>
In-Reply-To: <1034458414.15067.25.camel@irongate.swansea.linux.org.uk>
References: <1034458414.15067.25.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> First question:  Will compiling a kernel with
>> the network module resident (as opposed to a loadable
>> module) make network performance any better?  From
>> the reading, it appears that resident modules are only
>> faster in initialization, not runtime.  I'm new to
>> this, so please correct me if I'm wrong.
>
>Modules are very very fractionally slower than compiled in code due to
>TLB misses

Depends on which arch... on ppc32 (ahem... no bad joke pls ;),
function calls from modules to kernel or between modules has to
go through some "branch islands" as they don't fit within the
scope of a "short" branch PPC insn. So you also get a small
perf. loss there, but I bet it's barely measurable.


Ben.


