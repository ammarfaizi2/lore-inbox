Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263512AbTC3Dot>; Sat, 29 Mar 2003 22:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263515AbTC3Dot>; Sat, 29 Mar 2003 22:44:49 -0500
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:26372 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S263512AbTC3Dos>;
	Sat, 29 Mar 2003 22:44:48 -0500
Subject: Re: 2.5 module-init-tools/mk_initrd problems
From: Sid Boyce <sboyce@blueyonder.co.uk>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1048970779.847.70.camel@barrabas>
References: <1048970779.847.70.camel@barrabas>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Mar 2003 03:56:06 +0000
Message-Id: <1048996566.847.82.camel@barrabas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, found the problem, the mkinitrd script was looking for modules .o
instead of .ko, fixed script. I discovered that the RedHat source rpm
contained a mkinitrd script for 2.4 kernels.
Regards
Sid.

On Sat, 2003-03-29 at 20:46, Sid Boyce wrote:
> 	On both SuSE 8.1 and Mandrake 9.1rc2, I can't get mk_initrd to find
> modules.
> 	I've installed module-init-tools 0.9.10 (SuSE 8.1) and 0.9.9 (Mandrake
> 9.1rc2), mkinitrd 3.4.32 (SuSE 8.1) and 3.1.6 (Mandrake). "depmod -ae
> 2.5.66-ac1" finds no problems. 
> "mkinitrd --preload reiserfs --preload aic7xxx /boot/initrd-2.5.66-ac1
> 2.5.66-ac1" returns message on both systems e.g "no module reiserfs
> found for kernel 2.5.66-ac1".
>  strace says it's at least trying to look in the right top directory ...
> stat64("/lib/modules/2.5.66-ac1", {st_mode=S_IFDIR|0755, st_size=288,
> ...}) = 0
> 	I can't see why it's not searching further down to where the module is.
> Regards
> Sid.
> -- 
> Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
> Linux only shop
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

