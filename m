Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFMTjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFMTjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVFMTjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:39:08 -0400
Received: from opersys.com ([64.40.108.71]:44300 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261228AbVFMTim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:38:42 -0400
Message-ID: <42ADE334.4030002@opersys.com>
Date: Mon, 13 Jun 2005 15:49:08 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Andrea Arcangeli <andrea@suse.de>, Bill Huey <bhuey@lnxw.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com>
In-Reply-To: <20050613144022.GA1305@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney wrote:
> OK...  Then the idea is to dynamically redirect the symbolic link
> to include/linux-srt or include/linux-srt that you mentioned in your
> previous email, or is the symlink serving some other purpose?

What I'm suggesting is that rt patches shouldn't touch the existing
codebase. Instead, functionality having to do with rt should be
integrated in separate directories, and depending the way you
configure the kernel, include/linux would point to either
include/linux-srt or include/linux-hrt, much like include/asm
points to one of inclux/asm-*.

> So your focus is on system calls that can have totally separate
> realtime and non-realtime implementations?  Or am I missing some
> trick here?

There's no trick. It's just a layout thing. Hope the above
explains what I'm trying to say.

> How are you and Kristian looking to benchmark/compare the various
> combinations you call out above?  Seems like one would have to look
> at more than straight scheduling/interrupt latency to make a reasonable
> comparison.

I'm not sure that benchmarking would be relevant. This is just a
integration/layout/configuration/build suggestion. I don't think
that this organization will change anything to the benchmark
results.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
