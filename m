Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbVKYAJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbVKYAJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 19:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVKYAJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 19:09:56 -0500
Received: from link.pl ([212.160.251.2]:4224 "EHLO link.pl")
	by vger.kernel.org with ESMTP id S1161078AbVKYAJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 19:09:55 -0500
Date: Fri, 25 Nov 2005 01:09:51 +0100 (CET)
From: Piotr Majka <charvel@link.pl>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: bind-9.3.1 doesnt work with 2.6.14
In-Reply-To: <200511251057.06263.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.63.0511250100590.19047@link.pl>
References: <200511251057.06263.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After run named on 2.6.14 (I try 2.6.14-rcX too) I got in logfile:

Nov 10 18:24:57 xxx named[1845]: errno2result.c:109: unexpected error:
Nov 10 18:24:57 xxx named[1845]: unable to convert errno to isc_result: 
14: Bad address
Nov 10 18:24:57 xxx named[1845]: UDP client handler shutting down due to 
fatal receive error: unexpected error

and named dont respond to the query. I switch back to 2.6.13.2 - all 
work fine. Once again run 2.6.14 - the same error after few minutes of 
working.


# sh /home/linux-2.6.14/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux xxx 2.6.13.2-grsec #1 Sat Sep 24 18:30:11 CEST 2005 i686 
i686 i386 GNU/Linux

Gnu C                  4.0.1
Gnu make               3.80
binutils               2.16.91.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   058
# lsmod
Module                  Size  Used by
#


I try with, and without grsecurity patch - still the same. Seems that its 
vanila kernel bug related.


-- 
Piotr "Charvel" Majka | Uin: 20873695
GCM d- s-:- a- C++ UL++++ P+ L+++ E--- W+ N+++ !o !K w--- !O M V- PS+ PE !Y
PGP+ t--- !5 X R tv- b !DI D+ G++ e h r y++**
