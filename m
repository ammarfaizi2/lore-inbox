Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265993AbSKOIJJ>; Fri, 15 Nov 2002 03:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbSKOIIA>; Fri, 15 Nov 2002 03:08:00 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:51585 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265898AbSKOIG6>;
	Fri, 15 Nov 2002 03:06:58 -0500
Date: Fri, 15 Nov 2002 09:13:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Back out bad 'fix' in hid-input.c [7/13]
Message-ID: <20021115091347.F16779@ucw.cz>
References: <20021115090818.A16761@ucw.cz> <20021115090922.A16779@ucw.cz> <20021115091011.B16779@ucw.cz> <20021115091119.C16779@ucw.cz> <20021115091214.D16779@ucw.cz> <20021115091247.E16779@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021115091247.E16779@ucw.cz>; from vojtech@suse.cz on Fri, Nov 15, 2002 at 09:12:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.786.54.4, 2002-10-24 12:33:34+02:00, vojtech@suse.cz
  hid-input.c:  Back out a (wrong) find_next_zero_bit() patch from Arnaldo Carvalho de Melo.


 hid-input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Fri Nov 15 08:31:15 2002
+++ b/drivers/usb/input/hid-input.c	Fri Nov 15 08:31:15 2002
@@ -348,7 +348,7 @@
 	set_bit(usage->type, input->evbit);
 
 	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
-		usage->code = find_next_zero_bit(bit, usage->code, max + 1);
+		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
 	}
 
 	if (usage->code > max) return;

===================================================================

This BitKeeper patch contains the following changesets:
1.786.54.4
## Wrapped with gzip_uu ##


begin 664 bkpatch16408
M'XL(`,.BU#T``[54T6[:,!1]CK_B2GTIHB2^MG%")BI:.FW3-@TQ]1D9QQ`&
MB5%B:%?EXQ=21#M6H6UJDUC63:Z/SSD^RAG<EJ:(O:W]X8Q.R1E\M*6+O7)3
M&E\_U/78VKH.4IN98-\53)?!(E]O'*F_CY33*6Q-4<8>^OSPQOU<F]@;O_]P
M^^5J3$B_#\-4Y7/SW3CH]XFSQ5:MDG*@7+JRN>\*E9>9<<K7-JL.K16CE-5W
M%T-.N[)"2458:4P0E4"34"8B*<B>V&!/^V@]4L9I)+`;5HQ+I.0&T`\CZ7>%
M+X"R`&G`!""+.8^Y:%,64PI'F-!&Z%!R#:_+?$@TI(NDT_CIZQC@6NDEV(T#
M!>=WA<WG+9@M\F22FWLW>3"%G4P7[KP%Z\;F66$SN"KRFI&%H=I12RTD!KZ:
ME?7)9V`<J2"C)_=)YQ\O0JBBY/)QPY=5)\5BEX!@4TZ#9VH.'C"*$<>*=>NB
MZHED)I-(<A.%7";\V.G?T!JD/S#K$Q5(.6>]BO5$3S;Y.KELE[FW$D"4SLP@
M2?4:>V$-EQOM%EOU5SJ04E'O$.YU[)*)[#B3K'<BD_@FF7SM%#;JOD&GN&N>
M.E6CTP?V'S&]X5T$))\>)\_;E&IN.I?:UD3Z+]&OQP5DZA[:@!?PK+WU[NG7
7IE.CE^4FZTO!:2B%)+\`LIT(OC4%````
`
end
