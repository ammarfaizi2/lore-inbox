Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSDDOC2>; Thu, 4 Apr 2002 09:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313170AbSDDOCS>; Thu, 4 Apr 2002 09:02:18 -0500
Received: from ns.suse.de ([213.95.15.193]:34829 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313122AbSDDOCH>;
	Thu, 4 Apr 2002 09:02:07 -0500
Date: Thu, 4 Apr 2002 16:02:06 +0200
From: Dave Jones <davej@suse.de>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.5.8-pre1] nbd compile fixes...
Message-ID: <20020404160206.Y20040@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	pavel@atrey.karlin.mff.cuni.cz
In-Reply-To: <20020404135826.GG9820@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 03:58:26PM +0200, Stelian Pop wrote:
 > In fact, since nbd.c still reference 'queue_lock' I suspect that
 > the actual modifications to nbd.c were lost somewhere in etherspace
 > between Dave and Linus.

Correct, there's a missing part, that came from 2.4

 > Either provide the right fix for nbd.c or apply the attached patch,
 > which reverts the patch to nbd.h.

2.4 simply does a s/queue_lock/tx_lock/ on drivers/block/nbd.c
I'll push that to Linus later today

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
