Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSBEAIa>; Mon, 4 Feb 2002 19:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289308AbSBEAIR>; Mon, 4 Feb 2002 19:08:17 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:64058
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S289306AbSBEAIA>; Mon, 4 Feb 2002 19:08:00 -0500
Message-ID: <001d01c1add9$3a3ab900$0300000a@hypnos>
From: "Jon Anderson" <jon-anderson@rogers.com>
To: "Ken Brownfield" <brownfld@irridia.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200202031027.g13ARMN03118@ns.home.local> <20020204172942.C14297@asooo.flowerfire.com>
Subject: Re: 760MPX IO/APIC Errors...
Date: Mon, 4 Feb 2002 19:08:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.112.215.28] using ID <jon-anderson@rogers.com> at Mon, 4 Feb 2002 19:07:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get as far as APIC init. As soon as  that happens, I get a flood (many
hundred or more per second) of these "APIC error on CPU0: 04(04)" errors,
and any progress seems to cease. The machine may in fact still be booting,
but I can't tell because any startup messages/login prompts would flash by
too quickly for me to notice them. (Plus, I think booting becomes painfully
slow because of all the error reporting.) My problem seems to be different
from Willy Tarreau's problem, in that he has two CPUs, and his disabling
MPS1.4 fixes his problem. For me, I have one CPU, and disabling MPS1.4 does
not solve the problem. My only option is disabling all APIC support in the
kernel. The APIC is probably still spitting out errors at an incredible
rate, I just can't see them. :-) Though my problem is not typical.

I've been searching through the linux-kernel and linux-smp mailing lists for
situations similar to mine, and there have been (as far as I can find) two
identical incidents reported, both by people with one CPU in the Asus
A7M266-D, a 2 CPU board. In my case, a single Duron (morgan core -
reportedly SMPable) and in the other guy's case, a single Athlon MP. Since
nobody else complains, I assume it's because the majority people who own the
A7M266-D also own 2 CPUs - which doesn't seem to cause problems. My
suggestion would then be that if you want to get an A7M266-D, make sure your
budget can accomodate 2 CPUs. :-)

I hope my input is helpful,

jon anderson


----- Original Message -----
From: "Ken Brownfield" <brownfld@irridia.com>
To: "Willy Tarreau" <wtarreau@free.fr>
Cc: <jon-anderson@rogers.com>; <linux-kernel@vger.kernel.org>
Sent: Monday, February 04, 2002 6:29 PM
Subject: Re: 760MPX IO/APIC Errors...


> At what point do your machines stop booting, i.e., what was the last
> printed kernel message on the console?  Also, can you send me full
> dmesgs from your machines after booting?
>
> I'm trying to corelate these issues with APIC issues I've had in the
> past (and I'm thinking of getting the A7M266D at some point).
>
> Thanks,
> --
> Ken.
> brownfld@irridia.com
>
> PS: MPS1.4 ==> APIC_DM_FIXED?
>
> On Sun, Feb 03, 2002 at 11:27:22AM +0100, Willy Tarreau wrote:
> | Hi Jon,
> |
> | same motherboard here, but with 2 XP1800+.
> | It couldn't boot until I either disabled IO/APIC or disable MPS1.4
support
> | in the bios setup. Finally, I disabled MPS1.4 and let IO/APIC enabled
and
> | it works really well in SMP. (In fact, I couldn't really imagine how
fast
> | this could be !)
> |
> | Regards,
> | Willy
> |
> | -
> | To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> | the body of a message to majordomo@vger.kernel.org
> | More majordomo info at  http://vger.kernel.org/majordomo-info.html
> | Please read the FAQ at  http://www.tux.org/lkml/

