Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWIOTUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWIOTUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWIOTUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:20:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58079 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751395AbWIOTUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:20:22 -0400
Message-ID: <450AFCF0.3040503@us.ibm.com>
Date: Fri, 15 Sep 2006 14:20:16 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: karim@opersys.com
CC: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Tim Bird <tim.bird@am.sony.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal>	<20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu>	<4509B03A.3070504@am.sony.com>	<1158320406.29932.16.camel@localhost.localdomain>	<Pine.LNX.4.64.0609151339190.6761@scrub.home>	<1158323938.29932.23.camel@localhost.localdomain> <20060915104527.89396eaf.akpm@osdl.org> <450AEDF2.3070504@opersys.com>
In-Reply-To: <450AEDF2.3070504@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> > Although IMO this is a bit lame - it is quite possible to go into
> > SexySystemTapGUI, click on a particular kernel file-n-line and have
> > systemtap userspace keep track of that place in the kernel source across
> > many kernel versions: all it needs to do is to remember the file+line and a
> > snippet of the surrounding text, for readjustment purposes.
>
> Sure, if you're a kernel developer, but as I've explained numberous
> times in this thread, there are far more many users of tracing than
> kernel developers.
>   

This is so true (and the main reason we implemented a trace utility in 
SystemTap).

Several of the people that work with in my team are _not_ kernel 
developers.  They do not necessarily know the Linux kernel code enough 
to insert their own instrumentation.  On the other had, they do posses 
other very good knowledges about things specific to a particular 
software stack or a HW subsystem.  Structured predefined probe points 
(dynamic or static) allow people with limited  kernel hacking skills to 
feedback useful information back to developers of the kernel.

I agree with Karim that a trace tool (while useful to developers) is 
mostly targeted at a non kernel developer audience.  They are mostly 
meant to enhance the communication between developers and regular 
users.  Any solution that is intended to be dynamic replacement for 
LTTng needs to take these kinds of users into account.

-JRS
