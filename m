Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTLVPQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 10:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTLVPQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 10:16:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49064
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264358AbTLVPQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 10:16:31 -0500
Date: Mon, 22 Dec 2003 16:17:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Octave <oles@ovh.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031222151724.GB18767@dualathlon.random>
References: <20031221001422.GD25043@ovh.net> <1071999003.2156.89.camel@abyss.local> <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221184709.GO25043@ovh.net> <20031221185959.GE1494@louise.pinerecords.com> <20031221234350.GD4897@ovh.net> <Pine.LNX.4.58L.0312220921120.2691@logos.cnet> <20031222123036.GW12491@ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222123036.GW12491@ovh.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 01:30:36PM +0100, Octave wrote:
> > Hi Octave,
> > 
> > What do you mean with "server is down" ? The OOM killer killed an
> > application ? What were the messages?
> > 
> > Under out of memory, 2.4.22 should also kill a process, but you say it
> > doesnt.
> 
> Marcelo,
> 
> All I have with 
> - 2.4.24-pre1 is
> # echo 1 > /proc/sys/vm/vm_gfp_debug        
> # for i in `seq 1 100`; do ./full.pl &  done
> [1] 849
> [2] 850
> [...]                                                                                                 
> # tail -f /var/log/messages                                                                                                                    
> [...]
> 
> SOFTDOG: Initiating system reboot.

your softdog is too strict for the workload you're running. You can't
pretend a low latency scheduling behaviour with hundres oom. what you
see is perfectly normal.
