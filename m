Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272974AbTG3QGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272976AbTG3QGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:06:25 -0400
Received: from [217.222.53.238] ([217.222.53.238]:19467 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S272974AbTG3QGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:06:23 -0400
Message-ID: <3F27ECFA.5020005@gts.it>
Date: Wed, 30 Jul 2003 18:06:18 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lista1@telia.com, linux-kernel@vger.kernel.org
Subject: Re: Disk performance degradation
References: <20030729182138.76ff2d96.lista1@telia.com>	<3F2786E9.9010808@gts.it> <20030730035524.65cfc39a.akpm@osdl.org>
In-Reply-To: <20030730035524.65cfc39a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Stefano Rivoir <s.rivoir@gts.it> wrote:

>>Thanks for the hint. This seems to make things a little better, but I'm
>>still far away from 2.4 performances. I thought that anticipatory sched
>>could be part of the problem, and booting with elevator=deadline
>>does a little better... but using 2.4 is completely another thing.
>>By the way, -a 512 vs -a 8 is a kernel "change" or an hdpam one?
> 
> 
> What makes you think it is a disk performance problem at all?  All we know
> is that KDE applications take longer to start up, yes?

> How much memory is in that machine?  Can you run a `vmstat 1' trace during
> the "slow" operations?

I think I've got it. 2.4 fails to load DRI, so when X is up there is
memory available until the load of gnucash, the last operation. 2.6
loads dri and probably this eats too much too early, causing the
system to touch swap since the first operation after X startup. This
does not happen anymore disabling DRI in X.

Sorry for wasting your time :(

Thanks.

-- 
Stefano RIVOIR
GTS Srl



