Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVBXWpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVBXWpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVBXWpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:45:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54862
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262537AbVBXWlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:41:42 -0500
Date: Thu, 24 Feb 2005 23:41:34 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050224224134.GE20715@opteron.random>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224215136.GK8651@stusta.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

On Thu, Feb 24, 2005 at 10:51:36PM +0100, Adrian Bunk wrote:
> seccomp might be a nice feature under some circumstances.
> But the suggestion in the help text is IMHO too strong and therefore 
> removed by this patch.

Why too strong? The reason there is a config option is for the embedded
space, where clearly they want to compile into the kernel only the
strict features they use.

There are no risks in enabling seccomp and the size of the kernel image
won't change in any significant way either.

So I'd prefer to keep the "If unsure, say Y." and it seems appropriate
to me.

You have to say Y, if later on you want to sell your CPU resources with
Cpushare.  BTW, you can already test it if you download version 0.8 of
the LGPL'd Cpushare software, it'll connect to the server and it'll
execute a remote seccomp computation and then it'll hang around until
you stop it with ./stop_cpushare.sh (and you will see your client
connected in the homepage stats). I didn't finish writing all the code
yet but it's already a decent demo for the seccomp part at least.

Anyway the help text is a minor detail after all. Thanks to everyone who
helped and provided feedback about the seccomp patch, especially to
Andrew. I'm very glad to see it in -mm right now!
