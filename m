Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTFWAXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 20:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTFWAXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 20:23:14 -0400
Received: from ppp-62-245-163-27.mnet-online.de ([62.245.163.27]:59303 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264786AbTFWAXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 20:23:11 -0400
To: linux-kernel@vger.kernel.org
Subject: no crash after setting ESP to 0 in module
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Mon, 23 Jun 2003 02:37:16 +0200
Message-ID: <frodoid.frodo.87isqxmxxf.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I already asked this once, but since I got no answer I figured I'll
try it again, maybe this time someone has the time to quickly explain
me that thing.

If I build a kernel module which does something like, say:

MOV ESP, 0

in init_module() then I get an oops, insmod (or whatever process tried
to insert the module) gets killed by the kernel and everything goes on
like that never happened.

My question is now: why? How? I really expect the processor to fail
into a triple fault when doing such a nasty thing, since I am in Ring
0 and there isn't any stack to handle the stack fault exception.

Where's the magic?

Regards,
Julien

