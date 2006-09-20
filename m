Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWITTsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWITTsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWITTsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:48:15 -0400
Received: from opersys.com ([64.40.108.71]:33797 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932342AbWITTsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:48:13 -0400
Message-ID: <45119D49.2040607@opersys.com>
Date: Wed, 20 Sep 2006 15:58:01 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
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
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Michael Davidson <md@google.com>
Subject: Re: [PATCH] Linux Kernel Markers
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com> <20060920180808.GI18646@redhat.com> <451186F2.3060702@google.com> <45118D63.8070604@opersys.com> <451194DA.40300@google.com> <451199F4.3000006@opersys.com> <45119934.8080001@google.com>
In-Reply-To: <45119934.8080001@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Bligh wrote:
> You mean using the jump-over thing that was posted earlier?
> I thought the CPU erratas prevented doing that atomically
> properly. From my understanding of the last 24 hours discussion,
> it seemed like the ONLY thing we could do safely atomically was
> insert an int3. Which sucks, frankly, but still.

No. djprobes already does safely insert other stuff than just
int3, that's the whole point.

Here are the relevant postings by Hiramatsu-san:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115875912510827&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115875867519302&w=2

Unless there's something *I* fundamentally misunderstood from
Hiramatsu-san's implementation and input, djprobes can replace
the 5-byte filler with a 5-byte unconditional jump. IOW your
mechanism works, no int3s involved.

Karim

