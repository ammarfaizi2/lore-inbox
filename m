Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269158AbUINDCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269158AbUINDCk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUINDCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:02:01 -0400
Received: from holomorphy.com ([207.189.100.168]:25744 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269150AbUINDBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:01:45 -0400
Date: Mon, 13 Sep 2004 20:01:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, kronos@kronoz.cjb.net,
       linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040914030126.GV9106@holomorphy.com>
References: <20040912155035.GA17972@dreamland.darkstar.lan> <1095117752.1360.5.camel@krustophenia.net> <20040913163448.T1973@build.pdx.osdl.net> <1095128285.1752.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095128285.1752.4.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 19:34, Chris Wright wrote:
>> The mlock() bit is unecessary now.  Use rlimits on the audio users.
>> Which leaves realtime bits, plus others.  I had a more generic module
>> (per-capability) that would be a superset of this.  Perhaps that's a
>> better fit.  I'm travelling this week, so forgive the spotty replies.

On Mon, Sep 13, 2004 at 10:18:06PM -0400, Lee Revell wrote:
> I think this would be fine.  All we need is a way to allow users to run
> SCHED_FIFO processes and use mlockall() without being root and without
> having to patch the kernel.  It's a pretty simple requirement.

Please construct a entitlement/permission checking scheme for this that
is not so lax as removing permissions checks altogether conditionally
on some sysctl.


-- wli
