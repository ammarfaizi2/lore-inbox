Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317518AbSGJJvO>; Wed, 10 Jul 2002 05:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317519AbSGJJvN>; Wed, 10 Jul 2002 05:51:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:62942 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317518AbSGJJvM>;
	Wed, 10 Jul 2002 05:51:12 -0400
Date: Thu, 11 Jul 2002 11:52:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: O(1) scheduler "complex" macros
In-Reply-To: <Pine.LNX.4.44.0207111111280.6835-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207111151200.7858-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the correct macro is:

  #define task_running(rq, p) \
 	(((rq)->curr == (p)) || spin_is_locked(&(p)->switch_lock))

	Ingo

