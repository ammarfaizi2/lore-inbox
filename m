Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbUBZSDC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbUBZSDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:03:02 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:25996 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262845AbUBZSC6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:02:58 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16446.13520.5837.193556@laputa.namesys.com>
Date: Thu, 26 Feb 2004 21:02:56 +0300
To: markw@osdl.org
Cc: piggin@cyberone.com.au, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: AS performance with reiser4 on 2.6.3
In-Reply-To: <200402261748.i1QHmJE12429@mail.osdl.org>
References: <200402261748.i1QHmJE12429@mail.osdl.org>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org writes:
 > Hi Nick,
 > 
 > I started getting some results with dbt-2 on 2.6.3 and saw that reiser4
 > is doing a bit worse with the AS elevator.  Although reiser4 wasn't
 > doing well to begin with, compared to the other filesystems.  I have
 > links to the STP results on our 4-ways and 8-ways here:
 > 	http://developer.osdl.org/markw/fs/dbt2_stp_results.html

There were no changes between 2.6.2 and 2.6.3 that could affect reiser4
performance, so it is not clear why numbers are so different. Probably
results should be averaged over several runs. Also can you run test with

http://www.namesys.com/snapshots/2004.02.25/extra/e_05-proc-sleep.patch

applied? To use it turn CONFIG_PROC_SLEEP on (depends on
CONFIG_FRAME_POINTER), and do "cat /proc/sleep" before and after test
run.

 > 
 > -- 
 > Mark Wong - - markw@osdl.org

Nikita.
