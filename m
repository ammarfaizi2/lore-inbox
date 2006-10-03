Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWJCVsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWJCVsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWJCVsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:48:09 -0400
Received: from relay00.pair.com ([209.68.5.9]:52242 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1030325AbWJCVsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:48:07 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 3 Oct 2006 16:48:02 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: SHELLCODE Security Research <GoodFellas@shellcode.com.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: =?ISO-8859-1?Q?Registration=A0Weakness=A0?=
 =?ISO-8859-1?Q?in=A0Linux=A0Kernel's=A0Bin?= =?ISO-8859-1?Q?ary=A0formats?=
In-Reply-To: <1159902785.2855.34.camel@goku.staff.locallan>
Message-ID: <Pine.LNX.4.64.0610031645340.3514@turbotaz.ourhouse>
References: <1159902785.2855.34.camel@goku.staff.locallan>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1924244249-1159912105=:3514"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1924244249-1159912105=:3514
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 3 Oct 2006, SHELLCODE Security Research wrote:

> Hello,
> The present document aims to demonstrate a design weakness found in the
> handling of simply
> linked   lists   used   to   register   binary   formats   handled   by
> Linux   kernel,   and   affects   all   the   kernel families
> (2.0/2.2/2.4/2.6), allowing the insertion of infection modules in
> kernel­ space that can be used by malicious users to create infection
> tools, for example rootkits.

So the problem you find is that newly registered binfmts are inserted into 
the front of the binfmt list instead of the rear, and this means that a 
binfmt handler can slip in at runtime at run quietly before any other 
handler?

I'm not sure I see this as a real problem. If you can load a module into 
kernel space and access arbitrary symbols (not to mention run in ring 0) I 
think you can do a lot more than just hide out on the binfmt list.

Am I missing something?

> POC, details and proposed solution at:
> English version: http://www.shellcode.com.ar/docz/binfmt-en.pdf
> Spanish version: http://www.shellcode.com.ar/docz/binfmt-es.pdf
>
> regards,
> --
> SHELLCODE Security Research TEAM
> GoodFellas@shellcode.com.ar
> http://www.shellcode.com.ar
>

Thanks,
Chase
--8323328-1924244249-1159912105=:3514--
