Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWIOOZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWIOOZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWIOOZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:25:48 -0400
Received: from opersys.com ([64.40.108.71]:15111 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751521AbWIOOZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:25:47 -0400
Message-ID: <450ABA2A.9060406@opersys.com>
Date: Fri, 15 Sep 2006 10:35:22 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	 <Pine.LNX.4.64.0609141537120.6762@scrub.home>	 <20060914135548.GA24393@elte.hu>	 <Pine.LNX.4.64.0609141623570.6761@scrub.home>	 <20060914171320.GB1105@elte.hu>	 <Pine.LNX.4.64.0609141935080.6761@scrub.home>	 <20060914181557.GA22469@elte.hu> <4509B03A.3070504@am.sony.com>	 <1158320406.29932.16.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151339190.6761@scrub.home>	 <1158323938.29932.23.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151425180.6761@scrub.home>	 <1158327696.29932.29.camel@localhost.localdomain>	 <Pine.LNX.4.64.0609151523050.6761@scrub.home> <1158331277.29932.66.camel@localhost.localdomain>
In-Reply-To: <1158331277.29932.66.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> In the meantime perhaps the saner members of the static trace brigade
> can explain why gcc debug data isn't good enough for them when its good
> enough for kgdb to do single stepping at source level and variable
> printing ?

Care to explain how I can use to implement the equivalent of this:

@@ -1709,6 +1712,7 @@ switch_tasks:
   		++*switch_count;

   		prepare_arch_switch(rq, next);
+		TRACE_SCHEDCHANGE(prev, next);
   		prev = context_switch(rq, prev, next);
   		barrier();

Also, care to explain how kprobes can be used to access same data
without having to actually customize a probe point for every binary?

Thanks,

Karim
