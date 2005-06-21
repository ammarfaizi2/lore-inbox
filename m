Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVFUWuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVFUWuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVFUWtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:49:08 -0400
Received: from mail.tyan.com ([66.122.195.4]:25101 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262449AbVFUWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:48:04 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A4046AA@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12 with dual way dual core ck804 MB
Date: Tue, 21 Jun 2005 15:50:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to help. Can you say more detail ? I don't know how to souce
code tracing statement....

Do you mean setup one global buffer, and in the setup.c compare the node id
or node id to decide to write sth to the buffer, and print out when the cpu0
get the control again?

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Tuesday, June 21, 2005 3:36 PM
> To: YhLu
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: 2.6.12 with dual way dual core ck804 MB
> 
> On Tue, Jun 21, 2005 at 02:41:52PM -0700, YhLu wrote:
> > andi,
> > 
> > for the dual way dual core Opteron ck804 MB, the 2.6.12 
> still has the 
> > timing problem, I  still need to add one printk in 
> amd_detec_cmp after 
> > the phys_proc_id is setup.
> 
> Can you perhaps do some debugging to find out where it hangs? 
> 
> e.g. you could let CPU #1 write into a buffer from source 
> code tracing statement and then read that in CPU #0 after 
> some time out. That should not disturb timing.
> 
> -Andi
> 
