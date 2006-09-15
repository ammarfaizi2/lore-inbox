Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWIOSSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWIOSSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWIOSSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:18:51 -0400
Received: from dvhart.com ([64.146.134.43]:3811 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932136AbWIOSSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:18:50 -0400
Message-ID: <450AEE87.4080101@mbligh.org>
Date: Fri, 15 Sep 2006 11:18:47 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: karim@opersys.com, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>	 <20060914171320.GB1105@elte.hu>	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>	 <1158320406.29932.16.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>	 <1158323938.29932.23.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>	 <1158327696.29932.29.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151523050.6761@scrub.home>	 <1158331277.29932.66.camel@localhost.localdomain>	 <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain>
In-Reply-To: <1158332324.29932.82.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Also, care to explain how kprobes can be used to access same data
>>without having to actually customize a probe point for every binary?
> 
> 
> Thats why we have things like systemtap.
> 
> All we appear to lack is systemtap ability to parse debug data so it can
> be told "trace on line 9 of sched.c and record rq and next"

But that's the whole point - if it's not integrated into a marker as
source code, it requires manual intervention for every bloody release
to do. "line 9 of sched.c" is a farcically stupid way of doing tags
on a dynamically moving project like the linux kernel.

Yes, that may work OK for something that is very static, like a distro
snapshot, but as a general mechanism, it's unsustainable and broken.

M.
