Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263437AbTEMVY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263490AbTEMVXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:23:45 -0400
Received: from holomorphy.com ([66.224.33.161]:63676 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263437AbTEMVWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:22:48 -0400
Date: Tue, 13 May 2003 14:35:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, alexh@ihatent.com
Subject: Re: [PATCH] Re: 2.5.69-mm4 undefined active_load_balance
Message-ID: <20030513213527.GV8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, alexh@ihatent.com
References: <20030512225504.4baca409.akpm@digeo.com> <87vfwf8h2n.fsf@lapper.ihatent.com> <20030513001135.2395860a.akpm@digeo.com> <87n0hr8edh.fsf@lapper.ihatent.com> <20030513085525.GA7730@hh.idb.hist.no> <20030513020414.5ca41817.akpm@digeo.com> <3EC0FB9E.8030305@aitel.hist.no> <20030513162711.GA30804@hh.idb.hist.no> <20030513193847.GP8978@holomorphy.com> <20030513213110.GA655@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513213110.GA655@hh.idb.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 12:38:47PM -0700, William Lee Irwin III wrote:
>> Linus just committed a patch to eliminate such offenders.
>> Do you mean #if CONFIG_NR_SIBLINGS != 0 or #ifdef CONFIG_NR_SIBLINGS?

On Tue, May 13, 2003 at 11:31:10PM +0200, Helge Hafting wrote:
> I don't know this code well, I'm just guessing the rigth way
> to make it compile.  I don't know what's the "clean" way
> to do #if/#ifdefs either - I could probably do better if I knew.
> The problem was that CONFIG_SHARE_RUNQUEUE gets set even with
> configs where it doesn't make sense, (i.e. uniprocessor without HT)
> so I guessed it was some sort of misunderstanding about
> how #ifdef works.  I hope whoever wrote that code will
> take a look and either say "yes - that's what I meant"
> or fix it in a better way.

Your fix was correct (the alternative is some rearrangment of those
#defines) and I carried it out with some additional #ifdef -> #if
conversions to cover the rest of the cases visible in my config and
sent it to akpm in another patch.


-- wli
