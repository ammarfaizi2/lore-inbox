Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289293AbSANXT4>; Mon, 14 Jan 2002 18:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289282AbSANXSK>; Mon, 14 Jan 2002 18:18:10 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:36004 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289272AbSANXR0>; Mon, 14 Jan 2002 18:17:26 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Date: Mon, 14 Jan 2002 15:17:07 -0800 (PST)
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <3C4365EB.5AA2DEA3@didntduck.org>
Message-ID: <Pine.LNX.4.40.0201141515570.22904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my apologies for the terminology errors, I was trying to go from memory
from the thread here late last year.

David Lang

On Mon, 14 Jan 2002, Brian Gerst wrote:

> Date: Mon, 14 Jan 2002 18:12:43 -0500
> From: Brian Gerst <bgerst@didntduck.org>
> To: David Lang <dlang@diginsite.com>
> Cc: Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
> Subject: Re: Hardwired drivers are going away?
>
> David Lang wrote:
> >
> > the impact is in all calls to the module, if they are far calls instead of
> > near calls each and every call is (a hair) slower.
> >
> > so the code can be the same and still be slower to get to.
> >
> > you can argue that it's not enough slower to matter, but even Alan admits
> > there is some impact.
> >
> > David Lang
>
> Let's get the terminology right here (for x86 at least):
> Far jump: Changes to a new code segment, absolute address
> Near jump: Same code segment, 4-byte relative offset
> Short jump: Same code segment, 1-byte signed offset
>
> The kernel never uses far jumps except for some BIOS calls and during
> booting.  The difference betwen near and short jumps is very minute.
> Short jumps are limited to +/- 128 bytes, so are really only applicable
> for small loops.  All function calls between object files must be near
> jumps, as the assembler does not not know the distance of an unresolved
> symbol and must assume the largest possible offset.
>
> --
>
> 				Brian Gerst
>
