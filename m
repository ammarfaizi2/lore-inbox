Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUBZRsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUBZRsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:48:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:8899 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262902AbUBZRsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:48:32 -0500
Message-Id: <200402261748.i1QHmJE12429@mail.osdl.org>
Date: Thu, 26 Feb 2004 09:48:10 -0800 (PST)
From: markw@osdl.org
Subject: AS performance with reiser4 on 2.6.3
To: piggin@cyberone.com.au
cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I started getting some results with dbt-2 on 2.6.3 and saw that reiser4
is doing a bit worse with the AS elevator.  Although reiser4 wasn't
doing well to begin with, compared to the other filesystems.  I have
links to the STP results on our 4-ways and 8-ways here:
	http://developer.osdl.org/markw/fs/dbt2_stp_results.html

I noticed that __preempt_spin_lock was near the top of the profile and
about 2 times higher the with AS, compared to deadline.

I'm going to run through the other filesystems to see how the elevators
affect them.

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
