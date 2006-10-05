Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWJEV0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWJEV0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWJEV0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:26:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36290 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932220AbWJEV0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:26:35 -0400
Subject: Re: [Alsa-user] Pb with simultaneous SATA and ALSA I/O
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dominique Dumont <domi.dumont@free.fr>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       alsa-user <alsa-user@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1160081110.2481.104.camel@mindpipe>
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	 <13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	 <87y7rusddc.fsf@gandalf.hd.free.fr>  <1160081110.2481.104.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 22:52:13 +0100
Message-Id: <1160085133.1607.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-05 am 16:45 -0400, ysgrifennodd Lee Revell:
> I've heard that some motherboards do evil stuff like implementing legacy drive
> access modes using SMM which would cause dropouts without xruns
> reported.

They don't. SATA causes audio dropouts on some systems because its fast
enough to starve the audio device of regular enough access to the PCI
bus. If that is a problem the audio device should be tuning PCI
latencies

