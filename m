Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWA3Ulm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWA3Ulm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWA3Ull
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:41:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53126 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964968AbWA3Ull (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:41:41 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
	<20060129003606.7887ecd9.akpm@osdl.org>
	<m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0601301014570.6405@yvahk01.tjqt.qr>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 13:41:04 -0700
In-Reply-To: <Pine.LNX.4.61.0601301014570.6405@yvahk01.tjqt.qr> (Jan
 Engelhardt's message of "Mon, 30 Jan 2006 10:15:41 +0100 (MET)")
Message-ID: <m1irs15tzz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>
>>So threading init will work just fine.  The only case that will blow up
>>is calling exec from something that is not the thread group leader.
>>i.e.  If tgid == 1 but pid != 1 the kernel will cause pid == 1 to exit.
>
> Should not it, at its best, replace the whole thread group by the new 
> program and have things carry on?

You see the bug.

Eric

