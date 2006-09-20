Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWITRbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWITRbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWITRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:31:35 -0400
Received: from opersys.com ([64.40.108.71]:63250 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932120AbWITRbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:31:34 -0400
Message-ID: <45117D4D.3040408@opersys.com>
Date: Wed, 20 Sep 2006 13:41:33 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
CC: Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com>
In-Reply-To: <451141B1.40803@hitachi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Hiramatsu-san,

So here's a more intelligent answer than last time :)

Masami Hiramatsu wrote:
> This method is very similar to the djprobe.
> And I had gotten the same idea to support preemptive kernel.
...
> This means the below code, doesn't this?
> ---
> 	jmp 1f /* short jump consumes 2 bytes */
> 	nop
> 	nop
> 	nop
> 1:
> ---

YES, as pointed out by Mathieu, this does essentially the same.
And, yes, as mentioned earlier, this should work fine on
preemptable kernels.

> I think the djprobe can provide most of functionalities which
> your idea requires.

Indeed.

Thanks,

Karim

