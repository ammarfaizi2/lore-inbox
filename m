Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272554AbTHFVR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272570AbTHFVR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 17:17:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:4993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272554AbTHFVR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 17:17:28 -0400
Date: Wed, 6 Aug 2003 14:19:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: diegocg@teleline.es, reiser@namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-Id: <20030806141905.40126313.akpm@osdl.org>
In-Reply-To: <20030806180427.GC21290@matchmail.com>
References: <3F306858.1040202@mrs.umn.edu>
	<20030805224152.528f2244.akpm@osdl.org>
	<3F310B6D.6010608@namesys.com>
	<20030806183410.49edfa89.diegocg@teleline.es>
	<20030806180427.GC21290@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> On Wed, Aug 06, 2003 at 06:34:10PM +0200, Diego Calleja Garc?a wrote:
>  > El Wed, 06 Aug 2003 18:06:37 +0400 Hans Reiser <reiser@namesys.com> escribi?:
>  > 
>  > > I don't think ext2 is a serious option for servers of the sort that 
>  > > Linux specializes in, which is probably why he didn't measure it.
>  > 
>  > Why?
> 
>  Because if you have a power outage, or a crash, you have to run the
>  filesystem check tools on it or risk damaging it further.
> 
>  Journaled filesystems have a much smaller chance of having problems after a
>  crash.

Journalled filesytems have a runtime cost, and you're paying that all the
time.

If you're going 200 days between crashes on a disk-intensive box then using
a journalling fs to save 30 minutes at reboot time just doesn't stack up:
you've lost much, much more time than that across the 200 days.

It all depends on what the machine is doing and what your max downtime
requirements are.
