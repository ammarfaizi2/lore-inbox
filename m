Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290549AbSBFN7d>; Wed, 6 Feb 2002 08:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290536AbSBFN7Z>; Wed, 6 Feb 2002 08:59:25 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:38316 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290549AbSBFN7J>; Wed, 6 Feb 2002 08:59:09 -0500
Date: Wed, 6 Feb 2002 14:59:04 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: DevilKin <devilkin-lkml@blindguardian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: status on northbridge disconnection apm saving?
In-Reply-To: <20020206134630Z290523-13996+17947@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0202061449280.8336-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2002, DevilKin wrote:

> Hello,
>
> I was wondering if there has been some development concerning the northbridge
> disconnection bit and the joined apm saving you can do... I have an amd box,
> and it is running rather warm... during the periods that it isn't doing
> anything, i would love to have it 'reduce the heat'...
>
> I've found the vcool page on the net, but it's an linux-2.4.13 patch... and
> we're at 17 (stable)... even though i'll probably be able to apply it (with
> some offsets), i am wondering what the status is.
>
> Thanks!

i am working on an patch which performs power saving on athlon cpu's with
the acpi function of the kernel ... at the moment only via's kt 133/133a
and kt266/266a chipsets are supported, but other will follow soon (amd
760) ...
if you want, you could try my patch.
you can get it under:
http://cip.uni-trier.de/nofftz/linux/amd_cool.diff

it is a patch against the 2.4.17 kernel .

you have to enable acpi-processor idle states in the kernel and you have
to activate the patch at the kernel boot prompt with "amd_disconnect=yes".
this is cause there are several problems known with the power saving
function of the athlon/duron cpus ... i am working on this ....

there is also a newer testing version which reads a special register on
the cpu and shows the value at booting time ... if you have problems with
the patch, or ... better ... if you have no problems with the patch, it
would be verry nice if you could mail me the value it shows at boot :)

the newer version is:
http://cip.uni-trier.de/nofftz/linux/amd_cool_new.diff

there is no big difference between the to versions ... the new version
only reads the register (and ... if you say force_amd_clk=yes at the boot
prompt it modifys the register, but at the moment it is not clear whether
this function does write the right value ... so use this with care ... )

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

