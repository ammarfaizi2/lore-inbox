Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVAPEQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVAPEQe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVAPEQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:16:34 -0500
Received: from opersys.com ([64.40.108.71]:22286 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262421AbVAPEQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:16:29 -0500
Message-ID: <41E9EC5A.7070502@opersys.com>
Date: Sat, 15 Jan 2005 23:23:54 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: tglx@linutronix.de, Tim Bird <tim.bird@am.sony.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] Instrumentation (was Re: 2.6.11-rc1-mm1)
References: <20050114002352.5a038710.akpm@osdl.org>  <1105742791.13265.3.camel@tglx.tec.linutronix.de>  <41E8543A.8050304@am.sony.com> <1105794499.13265.247.camel@tglx.tec.linutronix.de> <41E9CCEF.50401@opersys.com> <Pine.LNX.4.61.0501160352130.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501160352130.6118@scrub.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Roman,

Roman Zippel wrote:
> On Sat, 15 Jan 2005, Karim Yaghmour wrote:
>>In addition, and this is a very important issue, quite a few
>>kernel developers mistook LTT for a kernel debugging tool, which
>>it was never meant to be. When, in fact, if you ask those who have
>>looked at using it for that purpose (try Marcelo or Andrea) you will
>>see that they didn't find it to be appropriate for them. And
>>rightly so, it was never meant for that purpose. Even lately, when
>>I suggested Ingo try using relayfs instead of his custom tracing
>>code for his preemption work, he looked at it and said that it
>>wasn't suited, but would consider reusing parts of it if it were
>>in the kernel.
> 
> Well, that's really a core problem. We don't want to duplicate 
> infrastructure, which practically does the same. So if relayfs isn't 
> usable in this kind of situation, it really raises the question whether 
> relayfs is usable at all. We need to make relayfs generally usable, 
> otherwise it will join the fate of devfs.

Hmm, coming from you I will take this is a pretty strong endorsement
for what I was suggesting earlier: provide a basic buffering mode
in relayfs to be used in kernel debugging. However, it must be
understood that this is separate from the existing modes and ltt,
for example, could not use such a basic infrastructure. If this is
ok with you, and no one wants to complain too loudly about this, I
will go ahead and add this to our to-do list for relayfs.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
