Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293410AbSCOW2T>; Fri, 15 Mar 2002 17:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293424AbSCOW2K>; Fri, 15 Mar 2002 17:28:10 -0500
Received: from h24-83-222-158.vc.shawcable.net ([24.83.222.158]:3205 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S293410AbSCOW2E>;
	Fri, 15 Mar 2002 17:28:04 -0500
Message-ID: <3C92704C.1070909@bcgreen.com>
Date: Fri, 15 Mar 2002 14:06:04 -0800
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
In-Reply-To: <1015784104.1261.8.camel@phantasy> <20020311013853.A1545@devcon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Picking nits, but....

Andreas Ferber wrote:

 > Setting the affinity of a whole process group also makes sense IMHO.
 > Therefore I think an interface more like the setpriority syscall
 > for sched_set_affinity (with two parameters which/who instead of a
 > single PID) would be more flexible, eg.
 >
 >     int sched_set_affinity(int which, int who, unsigned int len,
 >                            unsigned long *new_mask_ptr);
 >
 > with who one of {PRIO_PROCESS,PRIO_PGRP,PRIO_USER} and which according
 > to the value of who.

I soule suggest that the order be

int sched_set_affinity(int who, int which, unsigned int len,
                             unsigned long *new_mask_ptr);

This would have the {p,pg}id be the first thing that a programmer
would see (likely more important than the 'which'.).


-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

