Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136009AbRD0NQE>; Fri, 27 Apr 2001 09:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbRD0NPy>; Fri, 27 Apr 2001 09:15:54 -0400
Received: from [64.64.109.142] ([64.64.109.142]:25619 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136009AbRD0NPm>; Fri, 27 Apr 2001 09:15:42 -0400
Message-ID: <3AE970C6.42695F2E@didntduck.org>
Date: Fri, 27 Apr 2001 09:14:46 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: "Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion for module .init.{text,data} sections
In-Reply-To: <200104270449.VAA05279@adam.yggdrasil.com> <20010427103519.E679@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Thu, Apr 26, 2001 at 09:49:05PM -0700, Adam J. Richter wrote:
> >       A while ago, on linux-kernel, we had a discussion about
> > adding support for __initdata and __init in modules.  Somebody
> > (whose name escapes me) had implemented it by essentially adding
> > a vmrealloc() facility in the kernel.  I think I've thought of a
> > simpler way, that would require almost no kernel changes.
> >
> [implementation details snipped]
> 
> While you are at this, you could make the .exit.{text,data}
> sections swappable for modules (by allocating swappable pages fro
> them?) and only mark them unswappable, while the module is
> exiting.
> 
> Rationale: A device needed for swaping will never call exit
> stuff, because it is still in use. So I see no obvious race here.
> 
> Regards

__exit functions and data are usually too small to make the effort worth
it.  __init functions and data on the other hand could be quite large,
if they contain firmware data for example.

--

				Brian Gerst
