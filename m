Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbTF1S7D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 14:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265335AbTF1S7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 14:59:03 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:49383 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265332AbTF1S7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 14:59:01 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Asus CD-S520/A kernel I/O error
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20030628190047.GA629@deneb>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Sat, 28 Jun 2003 21:13:52 +0200
In-Reply-To: <20030628190047.GA629@deneb> (Marco Ferra's message of "Sat, 28
 Jun 2003 20:00:47 +0100")
Message-ID: <87k7b6xbf3.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, Marco Ferra wrote:

> Something's wrong on the kernels ide/atapi interface for cd-rom's.  I
> got a Asus CD-S520/A and it seems that I can't sweep from the
> beginning to the end of the CD without getting a sense error.
> Commands like:
> 
> dd if=/dev/scd0 of=/file.iso
> dd if=/dev/hdc of=/file.iso
> 
> give
> 
> ---
> 
> Jun 28 19:28:33 deneb kernel:  I/O error: dev 0b:00, sector 1159912
> Jun 28 19:28:33 deneb kernel:  I/O error: dev 0b:00, sector 1160064
> 
> (note) the sectors do change if I change de medium, but on the same
> medium the falty sectores are always the same.  All the cd's are in
> top conditions without a scratch and clean.

Does this happen in the middle of a CD or always at the end? If tha
latter is the case have a look at cdrecords README.verify. Then you are
bitten by the TAO readahead bug. Try to burn a CD with -raw96r.

regards
Markus

