Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTLCT5q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTLCT5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:57:45 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:56737 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S264533AbTLCT45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:56:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: 2.6.0: Unmounting unreachable file systems: ?
Date: Wed, 03 Dec 2003 20:51:10 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.12.03.19.51.07.529083@smurf.noris.de>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1070481070 5897 192.109.102.39 (3 Dec 2003 19:51:10 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Wed, 3 Dec 2003 19:51:10 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would very much like to be able to unmount NFS file systems whose server
is unreachable. Apparently this doesn't work when files are open on that
file system, which is a problem because lsof doesn't work either and thus
I can't easily _find_ these files ...

Any good ideas where to dig further?

@linux linux-2.5 $ sudo umount -f /mnt/smurf 
Cannot MOUNTPROG RPC: RPC: Port mapper failure - RPC: Unable to receive
umount2: Device or resource busy
umount: /mnt/smurf: device is busy
Cannot MOUNTPROG RPC: RPC: Port mapper failure - RPC: Unable to receive
umount2: Device or resource busy
umount: /mnt/smurf: device is busy
@linux linux-2.5 $ sudo lsof
[ hangs until the previous command is executed a few times on another
  console, but then doesn't report anything ]
@linux linux-2.5 $ mount
[...]
play.smurf.noris.de:/smurf on /mnt/smurf type nfs (rw,addr=192.109.102.42)
@linux linux-2.5 $

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
There is just one thing I can promise you about the outer-space program:
Your tax dollar will go farther.

