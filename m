Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbVICA12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbVICA12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVICA12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:27:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161085AbVICA11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:27:27 -0400
Date: Fri, 2 Sep 2005 17:27:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: John McGowan <jmcgowan@inch.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Kernel 2.6.13 breaks libpcap (and tcpdump).
Message-Id: <20050902172719.4eaaa6db.akpm@osdl.org>
In-Reply-To: <20050902184416.GA6468@localhost.localdomain>
References: <20050902184416.GA6468@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McGowan <jmcgowan@inch.com> wrote:
>
> Kernel 2.6.13. Breaks libpcap.
> 
> Fedora Core 2, gcc 3.3.3, Pentium III (933MHz)
> 
> I had written about my dismay that traceproto and tcptraceroute
> no longer worked and suspected that libnet was broken.
> 
> It seems that it is libpcap that is broken by kernel 2.6.13 and
> tcpdump itself no longer works.
> Well, it works ... but not correctly.
> 
>  Capture data, then look for ICMP messages
>  (e.g. Time Exceeded errors as in a traceroute)
>  by filtering the file.
>  
>   tcpdump -w 1.cap
>   tcpdump -f "ip proto \icmp" -r 1.cap
> 
> That works.
> 
> 
>  Filter incoming data, looking for ICMP messages:
>  
>   tcpdump -f "ip proto \icmp"
>  
> Well, that catches nothing.
> 
> 
> I tried recompiling (source RPM, Fedora Core 2) tcpdump
> (libpcap, tcpdump, etc.) and reinstalling. That did not
> fix the problem with tcpdump.
> 
> It also broke a tethereal script I was using (which I changed
> to capture all packets, which works as indicated above, and
> then used a '-R', read, filter to display the one's I want).
> 

(cc netdev)
