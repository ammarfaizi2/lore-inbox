Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129543AbQJaJVZ>; Tue, 31 Oct 2000 04:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129820AbQJaJVP>; Tue, 31 Oct 2000 04:21:15 -0500
Received: from dillweed.dsl.xmission.com ([166.70.14.212]:38218 "HELO
	winder.codepoet.org") by vger.kernel.org with SMTP
	id <S129543AbQJaJVM>; Tue, 31 Oct 2000 04:21:12 -0500
Date: Tue, 31 Oct 2000 02:25:18 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031022518.A10336@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <39FDB623.74C200A7@timpanogas.org> <E13qJlo-00077p-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <E13qJlo-00077p-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 30, 2000 at 06:34:55PM +0000
X-Operating-System: Linux 2.2.17, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 30, 2000 at 06:34:55PM +0000, Alan Cox wrote:
> 
> See www.uclinux.org; the uclinux guys started a 2.4 port recently. Basically
> the idea is to have a mm-nommu/ directory which implements a mostly compatible
> replacement for the mm layer (obviously stuff like mmap dont work without an
> mmu and fork is odd), and a set of binary loaders to load flat binaries with
> relocations.

mmap works -- you just can't do MAP_PRIVATE.  Everything has to be
MAP_SHARED.  There is no fork (though vfork works).  brk doesn't work,
and things like iopl, ioperm are pointless.  etc...

Oh, and when you do malloc something (malloc is mmap based) you
really want to remember to free it, since the system can't clean
up after you,

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org
--This message was written using 73% post-consumer electrons--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
