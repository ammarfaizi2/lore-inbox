Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKNTpX>; Tue, 14 Nov 2000 14:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQKNTpN>; Tue, 14 Nov 2000 14:45:13 -0500
Received: from smtp-abo-4.wanadoo.fr ([193.252.19.153]:44286 "EHLO
	antholoma.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129069AbQKNToy>; Tue, 14 Nov 2000 14:44:54 -0500
Date: Tue, 14 Nov 2000 20:25:33 +0100
To: Arjan van de Ven <adve@oce.nl>
Cc: linux-kernel@vger.kernel.org, petkan@spct.net
Subject: Re: Inconsistencies in 3dNOW handling
Message-ID: <20001114202532.A13576@bylbo.nowhere.earth>
In-Reply-To: <m13vZhZ-000OYhC@amadeus.home.nl> <20001114085729.A28456@pc1-adve.oce.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001114085729.A28456@pc1-adve.oce.nl>; from adve@oce.nl on Tue, Nov 14, 2000 at 08:57:29AM +0100
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 08:57:29AM +0100, Arjan van de Ven wrote:
> The test11pre2 code will also not run on a K6-II/III

I'll look at this.


> Some of the "MMX" instructions are part of "3Dnow" according  to AMD
> publications. This is especially true for the "prefetch" instructions which
> have a different memnonic/opcode on Intel CPU's.

If we don't use them on pure MMX-enabled machine, but only on 3Dnow
ones, what about renaming those *mmx* {files,funcs} to *3dnow* ?


> > > - BTW, what does this 512 stand for ?  Especially as it's used in
> > several places, a #define would seem nice at first glance.
> 
> The 512 is a rough estimate of the minimum size of the copy that makes it
> worth saving and restoring the extra processor-state for using mmx.

What about "#define MMX_MIN_ACCELERATED_COPYSIZE 512" in mmx.h ?

Er... s/MMX/3DNOW/ :)



Hm, noone commented my note about usercopy.c's 3dnow code being
possibly fixed by cut-and paste from elsewhere ?


Regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
debian-email:   <dirson@debian.org> |   Support Debian GNU/Linux:
                                    | Cheaper, more Powerful, more Stable !
http://ydirson.free.fr/             | Check <http://www.debian.org/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
