Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUHJDs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUHJDs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 23:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUHJDs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 23:48:56 -0400
Received: from smtp.knology.net ([24.214.63.101]:12458 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S266824AbUHJDsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 23:48:55 -0400
Subject: Re: Multicast Driver Testing Quick How-To v 0.3 [was: Re: List of
	pending v2.4 kernel bugs]
From: David Dillow <dave@thedillows.org>
To: Roger Luethi <rl@hellgate.ch>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040805133359.GA15129@k3.hellgate.ch>
References: <20040720142640.GB2348@dmt.cyclades>
	 <20040721112336.GA9537@k3.hellgate.ch> <20040730155613.GD2748@logos.cnet>
	 <410A8077.7020308@pobox.com> <20040730172939.GA24235@k3.hellgate.ch>
	 <410A8F17.8070401@pobox.com> <20040730182006.GA26545@k3.hellgate.ch>
	 <20040805133359.GA15129@k3.hellgate.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1092109732.15778.22.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Aug 2004 23:48:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 09:33, Roger Luethi wrote:

> We haven't joined the next group yet, so there should be no answer:
> 
> tester# ping -r -I eth0 -t 1 -c 2 224.1.1.37
> 
> Use packet sniffer to confirm that target is not seeing the request
> (use -p option for tcpdump or tethereal to prevent promiscuous mode)
> 
> Now join the group (Ethernet level):
> 
> target# ip maddr add 01:00:5e:01:01:25 dev eth0
> 
> tester# ping -r -I eth0 -t 1 -c 2 224.1.1.37
> 
> Use packet sniffer to confirm that target is seeing the request now.

Some versions of tcpdump/libpcap will enable all-multicast mode
regardless of options given and user. This bit me on RedHat 9 using
libpcap 0.7.2 and tcpdump 3.7.2 while testing the typhoon driver.

Dave
