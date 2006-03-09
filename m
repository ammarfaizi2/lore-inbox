Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWCIQYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWCIQYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCIQYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:24:04 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:23742 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932659AbWCIQYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:24:00 -0500
Message-ID: <4410563E.9030409@cfl.rr.com>
Date: Thu, 09 Mar 2006 11:22:22 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Luke-Jr <luke@dashjr.org>
CC: Jan Knutar <jk-lkml@sci.fi>, Anshuman Gholap <anshu.pg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com> <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com> <200603081311.42080.jk-lkml@sci.fi> <200603091517.31121.luke@dashjr.org>
In-Reply-To: <200603091517.31121.luke@dashjr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2006 16:26:16.0267 (UTC) FILETIME=[306441B0:01C64396]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14313.000
X-TM-AS-Result: No--3.100000-5.000000-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> Fund a project to implement a software modem. While a "real" modem might have 
> better performance, softmodems are more of a raw interface which can be 
> better in the long run-- for example, if some new super modulation is 
> produced for 1mbit over regular phone lines, you could possibly just upgrade 
> your modem software for the new feature. You can also use the modem for voice

Except that is not going to happen because there are laws of physics 
that must be obeyed.  The phone line is encoded with 64 Kbps inside the 
digital phone network so there is no possible way to modulate more data 
than that.  There is also the problem that the A/D converter ( which is 
all the "software modem" is -- it's basically a stripped down sound card 
) only runs fast enough to support 56,000 bps.  Even if it could run 
faster, that would place even _more_ load on the cpu.


> capabilities, and have your computer act as an answering machine while you're 
> not using it for the internet.
> (Note this is all theoretically possible, and might require actual coding to 
> achieve; just pointing out that softmodem isn't necessarilly worse than 
> hardmodems)

They ARE necessarily worse than real modems in that they require a fair 
amount of cpu cycles to perform all the DSP.  IIRC, this also has to be 
done in interrupt context to maintain the low latency required, which 
lowers the interactive responsiveness of the system - even when you are 
not transferring much data.


