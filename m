Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266048AbUI0NeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUI0NeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUI0Nd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:33:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48362 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266048AbUI0Nds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:33:48 -0400
Date: Mon, 27 Sep 2004 15:33:47 +0200
From: Jan Kara <jack@suse.cz>
To: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Consistent kernel hang during heavy TCP connection handling load
Message-ID: <20040927133347.GB25992@atrey.karlin.mff.cuni.cz>
References: <20040927082410.GB16869@atrey.karlin.mff.cuni.cz> <OMEGLKPBDPDHAGCIBHHJKEBPEJAA.aathan-linux-kernel-1542@cloakmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OMEGLKPBDPDHAGCIBHHJKEBPEJAA.aathan-linux-kernel-1542@cloakmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Yes, I have reproduced the problem on another machine running a
> similar kernel but with different network card, CPU, etc.
  OK, so it probably won't be hardware. Any debugging output? If I got
it right you are using RH kernel - can you try with the vanilla one from
ftp.kernel.org to rule out some RH specific patches? Can you send your
kernel configuration?

								Honza

> -----Original Message-----
> From: Jan Kara
> Subject: Re: Consistent kernel hang during heavy TCP connection handling
> load
> 
> 
>   Hello,
> 
> > Thanks for responding.  When I got no responses, I searched for ways
>   I don't have personaly much experience with debugging by above tools
> so I won't be of much help. As you describe the problem below I
> personaly think that you won't get much from them if the system is as
> unresponsive as you write.
> 
> > (3) Enabled sysrq on both kernels, including echo "1" > /proc/sys/kernel/sysrq
> > 
> > I'll wait for the next hang now, trying it on both kernels.  By the
> > way, the system is hung VERY badly--doesn't respond to anything, no
> > switching consoles, no keyboard events, no disk activity.  Dunno about
> > network, since I haven't put a sniffer on it yet.
>   Hmm.. that looks bad. Do you debug things under console and not
> in X? If that is the case either there is some hardware problem (you
> likely generate quite high load on the machine) or some driver is stuck
> with interrupts disabled. In case debugging tools don't help you can try
> to compile kernel with minimal config (just disable everything not
> needed to run the test). Also reproducing on a different machine would
> be useful to rule out hardware...
> 
> 								Honza
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
