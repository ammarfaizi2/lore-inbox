Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265906AbTLIOoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTLIOoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:44:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:33728 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265906AbTLIOoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:44:08 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 9 Dec 2003 15:43:57 +0100 (MET)
Message-Id: <UTC200312091443.hB9Ehv817033.aeb@smtp.cwi.nl>
To: mikpe@csd.uu.se
Subject: Re: [PATCH - RFC] number of Solaris slices
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Mikael Pettersson <mikpe@csd.uu.se>

    >People tell me that SOLARIS_X86_NUMSLICE should be 16 instead of 8.
    >And it seems there is some truth in that.
    >
    >On the other hand, there have certainly been times that 8 was the
    >right number. Instead of using a define for the number of slices
    >(partitions, if you prefer), is it OK for all Solaris versions to
    >use v->v_nparts?

    Your patch didn't break my dual boot Linux + Sol8 x86 box.
    It has about 8 slices in the Solaris partition.

Good - thanks!

I just tested it myself. Burned Solaris 8 install CDs,
[using ide-scsi, which worked fine for me under 2.6.0-test11 :-)],
installed and booted to see

 hda2: <solaris: [s0] hda5 [s1] hda6 [s2] hda7 [s6] hda8 [s8] hda9 [s9] hda10 >

so that this particular install indeed uses 16 and not 8 slices.
Expect to submit this patch when development thaws again.

Andries
