Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279035AbRKMU7F>; Tue, 13 Nov 2001 15:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279005AbRKMU64>; Tue, 13 Nov 2001 15:58:56 -0500
Received: from modem-2716.lemur.dialup.pol.co.uk ([217.135.138.156]:41231 "EHLO
	Mail.MemAlpha.cx") by vger.kernel.org with ESMTP id <S278968AbRKMU6p>;
	Tue, 13 Nov 2001 15:58:45 -0500
Posted-Date: Tue, 13 Nov 2001 20:51:01 GMT
Date: Tue, 13 Nov 2001 20:50:59 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Keith Owens <kaos@ocs.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changed message for GPLONLY symbols
In-Reply-To: <10444.1005619809@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0111132037440.3058-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith.

> When insmod detects a non-GPL module with unresolved symbols it
> currently says:

>> Note: modules without a GPL compatible license cannot use GPLONLY_
>>       symbols

> I thought that hint was self-explanatory, obviously it was not
> clear. Never underestimate the ability of lusers to misread a
> message.  insmod 2.4.12 will say

> Hint: You are trying to load a module without a GPL compatible
>	license and it has unresolved symbols.  The module may be
						^^^

Gramattically, "This" is better there.

>	trying to access GPLONLY symbols but the problem is more
>	likely to be a coding or user error. Contact the module
>	supplier for assistance.

> Does anyone think that this message can be misunderstood by anybody
> with the "intelligence" of the normal Windoze user?

Can I suggest the following wording instead:

 Q> HINT: You are trying to load a module with unresolved symbols
 Q>	  that does not have a GPL compatible licence. This module
 Q>	  may be trying to access GPLONLY symbols in the kernel,
 Q>	  but it is more likely to be one of the following:
 Q>
 Q>	   a. The module was compiled against a kernel other than
 Q>	      the current (`uname -r`) kernel.
 Q>
 Q>	   b. The author of the module has made a coding error.
 Q>
 Q>	  Please contact the module supplier for assistance.

Drop the output from `uname -r` in the place indicated, and there should
be little for the luser to complain about.

Also, if there is any means for modutils to determine whether the
current kernel has any CPLONLY symbols in it, and remove the bit about
GPLONLY symbols if there aren't any.

Best wishes from Riley.

