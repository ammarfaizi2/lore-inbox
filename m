Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUBLSFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266396AbUBLSFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:05:00 -0500
Received: from crete.csd.uch.gr ([147.52.16.2]:55454 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S266381AbUBLSE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:04:58 -0500
Organization: 
Date: Thu, 12 Feb 2004 19:59:26 +0200 (EET)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: linux-kernel@vger.kernel.org
cc: benh@kernel.crashing.org
Subject: Radeon fb patch
Message-ID: <Pine.GSO.4.58.0402121944170.12860@thanatos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1076608766=:12860"
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1076608766=:12860
Content-Type: TEXT/PLAIN; charset=US-ASCII

I tried to compile bk2 with the new radeofb patch, but it failed.
The problem exists if you have enabled drm for radeon, because
radeon_engine_reset is declared twice, once in drivers/char/drm/
radeon_cp.c and the second time in drivers/video/aty/radeon_accel.c.
The attached patch just renames radeon_engine_reset to
radeonfb_engine_reset in drivers/video/aty and also radeon_engine_init
to radeonfb_engine_init just for consistency. It compiles fine, but shows
garbage on my notebook. Don't know if it is my patch or the new radeonfb
code.

Regards
	Panagiotis Papadakos
---559023410-1804928587-1076608766=:12860
Content-Type: APPLICATION/octet-stream; name="radeonfb.diff.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0402121959260.12860@thanatos.csd.uch.gr>
Content-Description: 
Content-Disposition: attachment; filename="radeonfb.diff.bz2"

QlpoOTFBWSZTWTDPZfcAAn/fgAIwYX//23/n1iC/79/6UAOb2zKLagGgJRQk
8JNih6m1NMGKADEMRtMmp6nlD1BzRkxMAExGBGmBBiMEyYBGCUylT0NPUmmT
IGj1GjTQGgBoGgGgHNGTEwATEYEaYEGIwTJgEYFUQmghoUwmGqeUemkABpp6
gANB6lsC1OsRRJuTYjqjKhJyEIKG4oZGD9270k354WtatMKzjSF4wvW88Uw2
kqROGyNtVWCkp4ZNQIglzsW5LcKk6gqrbdOzYCYgOol62I0OMIX7JgJ02Ip4
bsXa9JKxkUwrEPPXtEsNSSSq3e5JJL1toJohQD2GOn2UyNnSCrgMLgmVx9nw
7SVDYq+nuWWTEu82+M4tlny1owtlVFpivjDKIN8ekSUhEmH3z/fr93o5Prkm
Mo5CTxFhshpZQl0BjCzczttttv6DHBzlKLIBcAMOQQhCJSn1B2QMZHAb6D7B
UV5h1DAcjGnb9peC/rUpcYjJm6zQOIqyyxdZ+7/Gz8MGg1Izz8mxLd9Uzk3H
BElCjLKpQFYKgmG+GNbyIkgMKyz6yC9Big89aWfASebN81WV1vSA3KzeeZmc
97bHPWi37oEPbNtpVkkLwwqqqqKTMy8lFZIpEeweOBUU8sPu9t7x7Y6kfqEZ
RdJ+/UBDCb4Qq00gDiCI+D64+CcrtIJE0JUI3Hzu1iUviRGOnOhKm/JYNAi3
0mebBrwDji6+ntv24dXndlljyMRlIrFqXdCMNY1DMDbYeYaIbEJ0vk9ifxTx
jtPPGFpEzJMFjdWoK9Na1G/pisQV7ThF5xQ4Bm+aN5u4Djyv3S6YgkjBEVmZ
maI8vn1dQb6bY5uZGGdJDWtU89sMu4mU+/GaWgThir095hSK4b/Vpsg9MEeH
gzIdHuwiIVBOMQUiNFbyrGsSHMC4T6PS6uxDAItfE4Dh39HZsw5UFsniDvEG
3GuIQmCQMaEKCL9+pxKmDDMbS8TJMS36hbPaI8D3kR3c/IJjeXQtrLPe3TKE
2xiL36ETInqVLTCnXpbL+hWn0WzzjJEZ4hztUGzWt9+QaB0Bx1mXjMy46yvT
mCR26B8DbfKN0p/8XckU4UJAwz2X3A==

---559023410-1804928587-1076608766=:12860--
