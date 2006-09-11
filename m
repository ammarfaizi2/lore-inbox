Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWIKMcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWIKMcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIKMcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 08:32:14 -0400
Received: from pc1.pod.cz ([213.155.227.146]:48793 "EHLO pc11.op.pod.cz")
	by vger.kernel.org with ESMTP id S1751439AbWIKMcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 08:32:13 -0400
Date: Mon, 11 Sep 2006 14:32:09 +0200
From: Vitezslav Samel <samel@mail.cz>
To: Metathronius Galabant <m.galabant@googlemail.com>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: top displaying 50% si time and 50% idle on idle machine
Message-ID: <20060911123209.GA29119@pc11.op.pod.cz>
Mail-Followup-To: Metathronius Galabant <m.galabant@googlemail.com>,
	Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com> <20060907175323.57a5c6b0.akpm@osdl.org> <1b270aae0609081403u11b76ae9v72ad933475a2319f@mail.gmail.com> <20060908224752.GK8793@ucw.cz> <1b270aae0609110405r183748d2y753c0e846229f1d0@mail.gmail.com> <1b270aae0609110449m2f71495cna78a6cb17e7ca649@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b270aae0609110449m2f71495cna78a6cb17e7ca649@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 01:49:57PM +0200, Metathronius Galabant wrote:
> >>>>>Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0%
> >>>>>wa,  0.0% hi, 50.0%si
> >
> >>> BTW what means si? (interrupt service time? google
> >>> didn't find anything)
> >
> >> 'soft interrupt' probably. try disconnecting network.
> >
> >The cause has been found. The timer of that machine is seriously
> >broken, 1 second is approximately 500ms long.
> >It is a HP DL360 G4 and I configured the kernel without ACPI or
> >similar. Maybe there are some strange BIOS power management schemes
> >active. I will look deeper into the problem and report back.
> >A broken timer is _very_ strange to me (I didn't encounter that in the
> >last 12 years w/ custom kernels).

  Try 2.6.18-rc6, there is a fix included (see Changelog:
"[PATCH] x86: increase MAX_MP_BUSSES on default arch")

	Cheers,
		Vita
