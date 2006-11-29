Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966656AbWK2KOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966656AbWK2KOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966680AbWK2KOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:14:34 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:26090 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S966656AbWK2KOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:14:33 -0500
Date: Wed, 29 Nov 2006 11:10:45 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Adrian Bunk <bunk@stusta.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [SOLVED] Re: [discuss] 2.6.19-rc5: known regressions (v2)
Message-ID: <20061129111045.212844cb@localhost>
In-Reply-To: <20061114174451.4afc9b6a@localhost>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<200611111008.37986.rjw@sisk.pl>
	<20061111102506.5f98688c@localhost>
	<200611111149.27370.rjw@sisk.pl>
	<20061111132929.56c4539e@localhost>
	<20061114174451.4afc9b6a@localhost>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 17:44:51 +0100
Paolo Ornati <ornati@fastwebnet.it> wrote:

> > > Okay, please let us know if it survives the next several cycles.
> > > 
> > > OTOH, the problem may be hiding.
> > 
> > Ok, and if it survives againg and again I can do a partial bisection...
> 
> "-rc5" is still alive: 6 days of uptime using suspend/resume many times
> every day...
> 
> so if the problem is there it's hiding very well.
> 
> 
> Now I'll slowly go back with older kernels and see what happens...

SHORT CONCLUSION: it was just a kernel miscompilation (I usually do
"make oldconfig; make clean; make" so I don't know if I missed "make
clean" or if it was caused by ccache...).


The fact that it's a miscompilation is "proved" by 3 simple things:

1) I've only seen the problem with that particular version

2) slow bisection pointed that the ipotetic bug was fixed between
4b1c46a3..d1ed6a3e, but I don't see any change that matters (on x86_64).

3) I'm running a clean recompiled 2.6.19-rc4-g4b1c46a3, that doesn't
have any problem.


:D

-- 
	Paolo Ornati
	Linux 2.6.19-rc4-g4b1c46a3 on x86_64
