Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287993AbSABXzY>; Wed, 2 Jan 2002 18:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287990AbSABXzG>; Wed, 2 Jan 2002 18:55:06 -0500
Received: from [217.9.226.246] ([217.9.226.246]:55936 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S287992AbSABX2d>; Wed, 2 Jan 2002 18:28:33 -0500
To: paulus@samba.org
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
	<15411.37817.753683.914033@argo.ozlabs.ibm.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <15411.37817.753683.914033@argo.ozlabs.ibm.com>
Date: 03 Jan 2002 01:28:42 +0200
Message-ID: <877kr0uyc5.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

Paul> Tom Rini writes:

>> Okay, here's a summary of all of the options we have:
>> 1) Change this particular strcpy to a memcpy
>> 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
>> optimization comes back on with this flag later on, it would be a
>> compiler bug, yes?)
>> 3) Modify the RELOC() marco in such a way that GCC won't attempt to
>> optimize anything which touches it [1]. (Franz, again by Jakub)
>> 4) Introduce a function to do the calculations [2]. (Corey Minyard)
>> 5) 'Properly' set things up so that we don't need the RELOC() macros
>> (-mrelocatable or so?), and forget this mess altogether.

Paul> I would add:

Paul> 6) change strcpy to string_copy so gcc doesn't think it knows what the
Paul>    function does

GCC thinks exactly what the function does.

