Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWIGQjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWIGQjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWIGQjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:39:23 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:48047 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161016AbWIGQjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:39:22 -0400
Date: Thu, 7 Sep 2006 18:35:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Teigland <teigland@redhat.com>
cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 14/16] GFS2: The DLM interface module
In-Reply-To: <20060907145823.GF7775@redhat.com>
Message-ID: <Pine.LNX.4.61.0609071832330.24855@yvahk01.tjqt.qr>
References: <1157031710.3384.811.camel@quoit.chygwyn.com>
 <Pine.LNX.4.61.0609051352110.24010@yvahk01.tjqt.qr> <20060907145823.GF7775@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,


>> >+int gdlm_get_lock(lm_lockspace_t *lockspace, struct lm_lockname *name,
>> >+		  lm_lock_t **lockp)
>>
>> [lm_lock_t is]
>> currently typedef'ed to void [...]. (One _could_
>> get rid of it, but better not while it is called lm_lock_t. Leave as-is
>> for now.)
>
>I'm wondering what you might suggest instead of using the lm_lockspace_t,
>lm_lock_t, lm_fsdata_t typedefs.  These are opaque objects passed between
>gfs and the lock modules.  Could you give an example or point to some code
>that shows what you're thinking?

What I was thinking about:
int gdlm_get_lock(void *lockspace, struct lm_lockname *name, void **lockp)


Jan Engelhardt
-- 
