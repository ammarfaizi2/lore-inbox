Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTFYInM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 04:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTFYInM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 04:43:12 -0400
Received: from ppp-62-245-209-36.mnet-online.de ([62.245.209.36]:19845 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264197AbTFYInM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 04:43:12 -0400
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no crash after setting ESP to 0 in module
From: Julien Oster <lkml@mf.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Wed, 25 Jun 2003 10:57:21 +0200
In-Reply-To: <1zf8.2M8.5@gated-at.bofh.it> (Mikulas Patocka's message of
 "Mon, 23 Jun 2003 15:10:06 +0200")
Message-ID: <frodoid.frodo.87y8zqbklq.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <1nxp.Y9.15@gated-at.bofh.it> <1zf8.2M8.5@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> writes:

Hello Mikulas,

>> Where's the magic?

> Processor will do double fault prior to triple fault. Double fault
> exception 8 points to a task switch gate --- and task switch doesn't
> require correct ESP. So it loads new ESP from task state segment of that
> gate and calls doublefault_fn.

A task switch gate! Finally that makes sense to me. Thanks for
pointing this out!

Regards,
Julien
