Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263329AbSJHN5R>; Tue, 8 Oct 2002 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263283AbSJHN4e>; Tue, 8 Oct 2002 09:56:34 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64660 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263232AbSJHNzZ>;
	Tue, 8 Oct 2002 09:55:25 -0400
Date: Tue, 8 Oct 2002 16:01:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Make NR_KEYS be KEY_MAX+1 [20/23]
Message-ID: <20021008160100.S18546@ucw.cz>
References: <20021008154824.I18546@ucw.cz> <20021008154904.J18546@ucw.cz> <20021008155003.K18546@ucw.cz> <20021008155045.L18546@ucw.cz> <20021008155125.M18546@ucw.cz> <20021008155236.N18546@ucw.cz> <20021008155651.O18546@ucw.cz> <20021008155825.P18546@ucw.cz> <20021008155915.Q18546@ucw.cz> <20021008160001.R18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008160001.R18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 04:00:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.54, 2002-10-07 15:38:11+02:00, vojtech@suse.cz
  Make NR_KEYS be (KEY_MAX+1) so that keybindings
  can be set for keys over 128.


 keyboard.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/include/linux/keyboard.h b/include/linux/keyboard.h
--- a/include/linux/keyboard.h	Tue Oct  8 15:25:24 2002
+++ b/include/linux/keyboard.h	Tue Oct  8 15:25:24 2002
@@ -2,6 +2,7 @@
 #define __LINUX_KEYBOARD_H
 
 #include <linux/wait.h>
+#include <linux/input.h>
 
 #define KG_SHIFT	0
 #define KG_CTRL		2
@@ -15,9 +16,9 @@
 
 #define NR_SHIFT	9
 
-#define NR_KEYS		128
+#define NR_KEYS		(KEY_MAX+1)
 #define MAX_NR_KEYMAPS	256
-/* This means 64Kb if all keymaps are allocated. Only the superuser
+/* This means 128Kb if all keymaps are allocated. Only the superuser
 	may increase the number of keymaps beyond MAX_NR_OF_USER_KEYMAPS. */
 #define MAX_NR_OF_USER_KEYMAPS 256 	/* should be at least 7 */
 

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.54
## Wrapped with gzip_uu ##


begin 664 bkpatch17922
M'XL(`,3<HCT``]54VV[30!!]SG[%2'D!HMA[\?HF4K4T%52A-$JI!$_5QM[4
M)HXW\JX#0?YXUFZ45I%"1>$%VQIY/!?/.7.T?;C5LHI[&_7-R"1#??B@M(E[
MNM;227Y:?Z:4]=U,K:2[RW+G2S<OU[5!-CX5)LE@(RL=]XC#]E_,=BWCWNSB
M_>W'LQE"HQ&<9Z*\ES?2P&B$C*HVHDCUJ3!9H4K'5*+4*VF$DZA5LT]M*,;4
MWIP$#'._(3[V@B8A*2'"(S+%U`M]#^T&.]V-?5!/,`X(I1$/&NKY$4=C(`X/
MF&.M!YBZ!+LX`,)C%L:$##"-,8:#GC`@,,3H'?S;R<]1`E=B*>'3[&YR\?4&
MYA)>V9>[J[,O`_(:M`*3"0-+N9WG99J7]]I6)*)L$[7E<J&J-JA!V1T`H:&#
M)D"93SB:/E*.AG]X(80%1B?/H,W+I*A3Z19Y6?]PVQF5J%(G>PH^\K!U(TX;
MEDC"HY3Y\X!)/@\/*?Y]NVZ+C(4X:#AC4=!IZEC%\Q+[N]'1NA7Y"SM3QB-*
M&V[_X7=:9(<BQ,$Q$3(8TO]$A`];NH9A];U[K*BF1Q?V`H%>>D!0?]<0WCYT
M[,XE)SM!8Q+:\&5G^ZE<Y.4>7J_W!!P:4]PF=M9]`Y^S7,-*6CI;'),YY`L0
M1='"6XFU!E')UE>),#)UX+HLMI8<2T.]EI7=4O5X*":93):Z7HUX*EC(Y`+]
)`HI:2/9O!0``
`
end
