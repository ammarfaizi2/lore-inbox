Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWBVXNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWBVXNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWBVXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:13:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:15849 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030331AbWBVXNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:13:30 -0500
Message-ID: <43FCEF68.BE296D49@tv-sign.ru>
Date: Thu, 23 Feb 2006 02:10:32 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] revert "Optimize sys_times for a single threadprocess"
References: <43FCE6AC.ED8BC108@tv-sign.ru> <Pine.LNX.4.64.0602221446080.30219@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> 
> On Thu, 23 Feb 2006, Oleg Nesterov wrote:
> 
> > tasklist_lock in sys_times() will be eliminated completely
> > by further patch.
> 
> Where is that patch? The patch would simply drop the locks?

Just sent it: "[PATCH 1/6] sys_times: don't take tasklist_lock"

It only drops tasklist_lock, sighand->siglock is still needed,
of course.

Oleg.
