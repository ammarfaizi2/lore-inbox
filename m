Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRA3Whz>; Tue, 30 Jan 2001 17:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbRA3Whf>; Tue, 30 Jan 2001 17:37:35 -0500
Received: from cmr2.ash.ops.us.uu.net ([198.5.241.40]:61663 "EHLO
	cmr2.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S130962AbRA3WhZ>; Tue, 30 Jan 2001 17:37:25 -0500
Message-ID: <3A774282.5285F5EF@uu.net>
Date: Tue, 30 Jan 2001 17:38:58 -0500
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: tori@tellus.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: WOL and 3c59x (3c905c-tx)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Linksys WOL ethernet card and it all has some issues with WOL. 
My PC will wake fine if I shut it down in linux (using apm).  It will
also stay off after I shut it down.  If I shutdown from within win98 or
using the power button, it will boot it's self up within 1-2 minutes of
being turned off.  The only way to make it stay off is to boot linux and
shut it down.  I'm using 2.4.0 with apm in kernel.  Same behavior in the
2.4test kernels.

It's not too bothersome since I rarely run win98, but it is strange...

Alex


------------------------------

When shutting down my computer with Linux, I cannot wake it up using 
wake-on-LAN, which I can do if I shut it down from WinME or the LILO 
prompt using the power button. 

I see some "interesting" code in 3c59x.c and acpi_set_WOL, and there is 
the following little comment: "AKPM: This kills the 905". 

So, what's up? Does it break all 905s? And will not changing the state 
to D3, as a comment a few lines down says, shut the card down, which
seems 
to be a bad thing to do in a function called from vortex_probe1... I
know 
this code is currently bypassed, but still, what is this? 

/Tobias
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
