Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSGNPZU>; Sun, 14 Jul 2002 11:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSGNPZU>; Sun, 14 Jul 2002 11:25:20 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:42249 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316895AbSGNPZT>; Sun, 14 Jul 2002 11:25:19 -0400
Date: Sun, 14 Jul 2002 12:27:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: aia21@cantab.net, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141515.g6EFFbhs019189@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44L.0207141223320.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Joerg Schilling wrote:

> Well, I get pissed of the fact that it seems to be impossible to have a
> technical based discussion in the Linux kernel environment.

Then please, show us your technical arguments on why the SCSI
layer is enough for every CD writing hardware out there.

Now compare them with the results from the NAS and SCSI talks
and BoFs at the kernel summit and OLS, where everybody agreed
that the current SCSI addressing and discovery schemes just
don't cut it on things like iscsi and other network storage
solutions.

It's not just about the fact that the controller/bus/unit/lun
addressing doesn't deal well with network attached storage and
multipath, it's also about things like the impossability of
device discovery on a bus with 2^32 possible device addresses.

This, in turn, makes the current sd[a-z] and sg[a-h] more than
a little inadequate.  Furthermore, you suddenly require the
ability to tell the kernel to talk to devices the kernel doesn't
yet know about (because it can't scan 2^32 device addresses at
boot time).

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

