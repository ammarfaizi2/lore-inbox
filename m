Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSGXBXN>; Tue, 23 Jul 2002 21:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSGXBXN>; Tue, 23 Jul 2002 21:23:13 -0400
Received: from spud.dpws.nsw.gov.au ([203.202.119.24]:8094 "EHLO
	spud.dpws.nsw.gov.au") by vger.kernel.org with ESMTP
	id <S315988AbSGXBXM>; Tue, 23 Jul 2002 21:23:12 -0400
Message-Id: <sd3e8edb.011@out-gwia.dpws.nsw.gov.au>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Wed, 24 Jul 2002 11:25:42 +1000
From: "Daniel Lim" <Daniel.Lim@dpws.nsw.gov.au>
To: "<Andreas Steinmetz" <ast@domdv.de>, <thunder@ngforever.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mkinitrd problem
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
My problem is fixed, it was for some reasons, due to corrupted or
imcompatible module for
/lib/modules/2.4.2-2/kernel/drivers/block/loop.o, I restored the module
and it all worked like charms.
Thanks for all your help.

Regards,
Daniel

>>> Thunder from the hill <thunder@ngforever.de> 23/07/2002 18:25:04
>>>
Hi,

On Tue, 23 Jul 2002, Daniel Lim wrote:
> /lib/modules/2.4.2-2/kernel/drivers/block/loop.o: unresolved symbol
> do_generic_file_read_R63b9dc6b

This is you're trying to use the correct module, but it's from the
wrong 
kernel version. BTW, yes, you might try losetup -d /dev/loopx (or even

better, when no loop devices are mounted,

for d in /dev/loop*; do
	losetup -d $d
done)

BAW, what's your kernel (uname -r)?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/ 



 This e-mail message (and attachments) is confidential, and / or privileged and is intended for the use of the addressee only. If you are not the intended recipient of this e-mail you must not copy, distribute, take any action in reliance on it or disclose it to anyone. Any confidentiality or privilege is not waived or lost by reason of mistaken delivery to you. DPWS is not responsible for any information not related to the business of DPWS. If you have received this e-mail in error please destroy the original and notify the sender.

For information on services offered by DPWS, please visit our website at www.dpws.nsw.gov.au



