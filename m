Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRC2Vgc>; Thu, 29 Mar 2001 16:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRC2VgW>; Thu, 29 Mar 2001 16:36:22 -0500
Received: from jalon.able.es ([212.97.163.2]:7621 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129166AbRC2VgO>;
	Thu, 29 Mar 2001 16:36:14 -0500
Date: Thu, 29 Mar 2001 23:35:21 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Fabio Riccardi <fabio@chromium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux scheduler limitations?
Message-ID: <20010329233521.C6053@werewolf.able.es>
In-Reply-To: <3AC3A6C9.991472C0@chromium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3AC3A6C9.991472C0@chromium.com>; from fabio@chromium.com on Thu, Mar 29, 2001 at 23:19:05 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.29 Fabio Riccardi wrote:
> 
> I've found a (to me) unexplicable system behaviour when the number of
> Apache forked instances goes somewhere beyond 1050, the machine
> suddently slows down almost top a halt and becomes totally unresponsive,
> until I stop the test (SpecWeb).
> 

Have you though about pthreads (when you talk about fork, I suppose you
say literally 'fork()') ?

I give a course on Parallel Programming at the university and the practical
work was done with POSIX threads. One of my students caught the idea and
used it to modify his assignment from one other matter on Networks, and
changed the traditional 'fork()' in a simple ftp server he had to implement
by 'pthread_create' and got a 10-30 speedup (conns per second).

And you will get rid of some process-per-user limit. But you will fall into
an threads-per-user limit, if there is any.

And you cal also control its scheduling, to make each thread fight against
the whole system or only its siblings.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac28 #1 SMP Thu Mar 29 16:41:17 CEST 2001 i686

