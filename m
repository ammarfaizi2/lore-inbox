Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbULGNjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbULGNjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbULGNjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:39:36 -0500
Received: from gate.corvil.net ([213.94.219.177]:12548 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261612AbULGNje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:39:34 -0500
Message-ID: <41B5B282.9040909@draigBrady.com>
Date: Tue, 07 Dec 2004 13:39:14 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: Karsten Desler <kdesler@soohrt.org>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
References: <20041206205305.GA11970@soohrt.org>	 <20041206134849.498bfc93.davem@davemloft.net>	 <20041206224107.GA8529@soohrt.org> <41B58A58.8010007@draigBrady.com>	 <20041207112139.GA3610@soohrt.org> <16821.42080.932184.167780@robur.slu.se>	 <20041207125001.GA26644@soohrt.org> <1102424673.1093.124.camel@jzny.localdomain>
In-Reply-To: <1102424673.1093.124.camel@jzny.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> On Tue, 2004-12-07 at 07:50, Karsten Desler wrote:
> 
> 
>>Currently I'm having problems capturing packets with tcpdump (lots of
>>"packets dropped by kernel") which indicates to me that there's
>>genuinely not much (enough) idle time sitting around.
>>
> 
> Ah, more hints. So you are not trying to forward - rather just packet
> capturing?
> Are you using a tcpdump patched with mmaped packet socket?
> 
> The 230-240Kpps you are reporting as a capture dont seem as unreasonable
> as i thought then. Neither would the CPU use.

Yes this is vital Karsten, otherwise tcpdump
will do 2 syscalls per packet, which is the
bottleneck in my experience.

You may want to try a simpler capture program that
uses the kernel PACKET_MMAP feature directly:
http://www.scaramanga.co.uk/code-fu/lincap.c

-- 
Pádraig Brady - http://www.pixelbeat.org
--
