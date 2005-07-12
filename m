Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVGLDGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVGLDGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVGLDGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:06:52 -0400
Received: from opersys.com ([64.40.108.71]:22285 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261876AbVGLDGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:06:19 -0400
Message-ID: <42D3321B.7030405@opersys.com>
Date: Mon, 11 Jul 2005 22:59:39 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
References: <17107.6290.734560.231978@tut.ibm.com>	<20050712022537.GA26128@infradead.org> <20050711193409.043ecb14.akpm@osdl.org>
In-Reply-To: <20050711193409.043ecb14.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> Still, first let us get a handle on who wants relayfs now and in the future
> and for what.  Then we can better decide.

We used relayfs for our series of tests on PREEMPT_RT and I-Pipe.
Specifically, we used relayfs buffers to store the timestamps for our
interrupt latency measurements. This allowed us to easily have access
to very large buffering areas without having to worry about any form
of detailed resource allocation, or runtime overhead of logging. IOW,
it allowed us to concentrate on our main priority: log a very large
amount of timestamps.

On the LTT side, relayfs is bound to be at the center of whatever
architecture we settle on for the ongoing rewrite. For having used it
for past releases of LTT, we know that it can handle very heavy data
throughput with little overhead using a relatively simple API.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
