Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRFBXjd>; Sat, 2 Jun 2001 19:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbRFBXjX>; Sat, 2 Jun 2001 19:39:23 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:50685 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262262AbRFBXjP>; Sat, 2 Jun 2001 19:39:15 -0400
Message-Id: <l03130300b73f28b41743@[192.168.239.105]>
In-Reply-To: <OE11ur2iz2Mb1s7nlT200005c9b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 3 Jun 2001 00:39:03 +0100
To: "M.N." <balkanboy@hotmail.com>, <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: is a kernel panic supposed to happen if root fs is on a SCSI
 disk and SCSI support is compiled in as module?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:17 am +0100 3/6/2001, M.N. wrote:
>Basically, that's the question. I compiled my kernel with the SCSI AIC7xxx.o
>driver as a module, and then when it booted up, it paniced. I thought it was
>some sort of a kernel bug, but it didn't really seem that way when I
>recompiled the kernel with SCSI support built-in in the kernel itself
>(monolithically).  I'm just curious, does a _panic_ necessarily mean that
>the kernel needs fixing, or can a panic be a result of something that the
>user forgot to do which was required in order to avoid that panic?

A kernel panic happens whenever it finds itself in a situation which is
impossible or impractical to fix.  In your case, it needed the SCSI module
in order to load the root FS.  But the SCSI module is itself located on the
root FS.  Catch 22, so panic.  If you'd read the module documentation,
you'd have known about this beforehand, but chalk this up to experience
(aka. RTFM!).

So, a kernel panic usually means it's a configuration error OR hardware
failure OR (rarely) a kernel bug.  Most often, kernel bugs are marked by an
OOPS or BUG message splashing all over the console and the system log.

HTH,

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


