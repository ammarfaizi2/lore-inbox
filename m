Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWA3JPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWA3JPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWA3JPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:15:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25732 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932153AbWA3JPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:15:50 -0500
Date: Mon, 30 Jan 2006 10:15:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
In-Reply-To: <m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0601301014570.6405@yvahk01.tjqt.qr>
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com> <20060129003606.7887ecd9.akpm@osdl.org>
 <m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>So threading init will work just fine.  The only case that will blow up
>is calling exec from something that is not the thread group leader.
>i.e.  If tgid == 1 but pid != 1 the kernel will cause pid == 1 to exit.

Should not it, at its best, replace the whole thread group by the new 
program and have things carry on?


Jan Engelhardt
-- 
