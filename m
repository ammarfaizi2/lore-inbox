Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUHRPIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUHRPIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUHRPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:08:49 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:56181 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266808AbUHRPIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:08:47 -0400
Subject: 2.6.8-rc4+ ide errors causes system freeze
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 18 Aug 2004 17:08:46 +0200
Message-Id: <1092841726.11739.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey, i notice that after beginning to use a 2.6.8rc4 kernel my system
crashed some times - and i just accepted it and thought it would be
fixed in 2.6.8 (i couldnt just find the error)

but its still here - then i digged down in the syslog, and found some
interresting stuff
this happens mostly with videos and stuff.
when the system does this it will just completely lockup, i cant sync
disk, remount readonly, or kill any processes(all with magic sysrq key),
i can only use the sysrq key to reboot or shutdown.

i hope you can help me :>
thanks!

log:

Aug 18 16:46:30 redeeman hdb: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Aug 18 16:46:30 redeeman hdb: dma_intr: error=0x84 { DriveStatusError
BadCRC }
Aug 18 16:46:30 redeeman ide: failed opcode was: unknown
Aug 18 16:46:36 redeeman hdc: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Aug 18 16:46:36 redeeman hdc: dma_intr: error=0x84 { DriveStatusError
BadCRC }
Aug 18 16:46:36 redeeman ide: failed opcode was: unknown
Aug 18 16:46:49 redeeman hdd: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Aug 18 16:46:49 redeeman hdd: dma_intr: error=0x84 { DriveStatusError
BadCRC }
Aug 18 16:46:49 redeeman ide: failed opcode was: unknown
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^$
<AE>3<95>QQ<E5>^
\<8F><DA>d<D4><F9><B2>e<B4><94><DE>5<CB><E9><B9>f<C3>`<ED><A7><C2>>@^O<A9><C7><85><E5>IM<A8>.<8F><A4><F0>4<DC>T<B5>^_g<85><BD><A8>Q>S<C7><99><8C>r<E9>`j^Z<D0><B7><86><E1><94>^Ta^?$
<DC>^_<D7>^]:*<B4><D2>8<FC><8B><FB><8F>%]`<8A><B6>~Qi^Zf
#<B3><9B>^E<BD><AE>^Op^F5<E0><C2><AF>(K<D3>$<AF>+<A3>+<C1>$<C5>y<8A><DC><BD><AD>m<EF><E7><D7><A7><CB>^R<F3><C0><EA><BF>"<BD>^D<A7><F1>eHc<A6>
<94><B4><93>IN<A4>F<A0>k-<E0>^Gr<A5>@<EE>|A<BB>[^Z
$<CC><ED>P<AA><AA><E1>Ti<C5>2&<E9><C9>^E<CF><88><DD>A<F0>^Q<D2><C0><8D><CE>%<F2>;<CE>^AA


