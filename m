Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUFXAoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUFXAoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 20:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUFXAoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 20:44:32 -0400
Received: from web51806.mail.yahoo.com ([206.190.38.237]:18362 "HELO
	web51806.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263304AbUFXAo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 20:44:29 -0400
Message-ID: <20040624004429.76093.qmail@web51806.mail.yahoo.com>
Date: Wed, 23 Jun 2004 17:44:29 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: slow performance w/patch-2.6.7-mjb1
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1945190000.1088003081@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin et al:

Here is a litle bit more information:
2.6.7-mjb1 w/4G split enabled:
44.91user 56.95system 1:46.30elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+6907875minor)pagefaults
0swaps


2.6.7-mjb1 w/4G disabled enabled:
30.71user 34.56system 1:11.29elapsed 91%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (21major+6907525minor)pagefaults
0swaps

Clearly something is wrong.  This is making headers
which does a lot of spawning of bash shells and ln -s
different files and some minor dependancy makes.

Any help understanding what is happending here would
be greatly appreciated!

Thanks!
Phy


--- "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> > So I configed with your patch just the basics and
> get
> > similar times that I do with 2.6.7 virigin and
> 2.4.21.
> >  However, as soon as I enable 4G split, the rt
> > increases by ~35s (out of 1m45s compared to
> 1m10s). 
> > Do you know if this is in line w/expectations?  Is
> > there anyway to reduce this?
> 
> Syscalls, etc will definitely be slower ... but it's
> not normally
> that severe ... what's the workload? And how much of
> hte increase
> is systime vs user time? (use /usr/bin/time, not the
> shell builtin)
> 
> M.
> 
> 
> 
> 



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
