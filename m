Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUIXO1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUIXO1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 10:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUIXO07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 10:26:59 -0400
Received: from coltrane.tcs.informatik.uni-muenchen.de ([129.187.228.100]:2506
	"EHLO coltrane.tcs.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S268803AbUIXO0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 10:26:36 -0400
Date: Fri, 24 Sep 2004 16:26:31 +0200
From: "Oliver M. Bolzer" <oliver@fakeroot.net>
To: linux-kernel@vger.kernel.org
Subject: Re: qla2xxx: frequent total lockups (2.6.8, 2.6.9-rc{1-mm5,2})
Message-ID: <20040924142631.GA15004@magi.fakeroot.net>
Reply-To: linux-kernel@vger.kernel.org
References: <20040915231657.GA2005@magi.fakeroot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915231657.GA2005@magi.fakeroot.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Sep 16, 2004 at 01:16:59AM +0200, "Oliver M. Bolzer" <oliver@fakeroot.net> wrote...
 
>As soon as there is I/O load on the HBA, I start seeing
> 
>qla2300 0000:01:03.0: qla2xxx_eh_abort: cmd already done sp=0000000000000000
> 
>messages every few seconds, eventually leading to complete system lockups after
>several minutes up to several hours, due to kernel NULL pointer dereferences
>in qla2x00_cmd_timeout().
 
> I've tested and reproduced the error on the following kernels, all
> compiled for x86_64.
> 2.6.8.1
> 2.6.9-rc1-mm5 (with dma_fixups patch posted by Andrew Vasquez on 13.9)
> 2.6.9-rc2 

2.6.9-rc2-mm2 seems to have fixed the problem.
It is rather puzzling since the difference in the qla2xxx driver between
2.6.9-rc1-mm5+qlogic-oops-fix and 2.6.9-rc2-mm2 is rather minimal. Maybe
the problem was caused by some other part of the kernel that has now
been fixed.



-- 
	Oliver M. Bolzer
	oliver@gol.com

GPG (PGP) Fingerprint = 621B 52F6 2AC1 36DB 8761  018F 8786 87AD EF50 D1FF
