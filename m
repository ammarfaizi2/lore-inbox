Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272368AbRIPQTF>; Sun, 16 Sep 2001 12:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272404AbRIPQSz>; Sun, 16 Sep 2001 12:18:55 -0400
Received: from net.spam.ee ([194.204.44.99]:52474 "HELO x153.internalnet")
	by vger.kernel.org with SMTP id <S272368AbRIPQSi>;
	Sun, 16 Sep 2001 12:18:38 -0400
Subject: Re: broken VM in 2.4.10-pre9
From: Tonu Samuel <tonu@please.do.not.remove.this.spam.ee>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9o1dev$23l$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance> 
	<9o1dev$23l$1@penguin.transmeta.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 17 Sep 2001 18:25:38 +0800
Message-Id: <1000722338.14005.0.camel@x153.internalnet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2001 05:31:11 +0000, Linus Torvalds wrote:

> Also note that the amount of "swap used" is totally meaningless in
> 2.4.x. The 2.4.x kernel will _allocate_ the swap backing store much
> earlier than 2.2.x, but that doesn't actuall ymean that it does any of
> the IO. Indeed, allocating the swap backing store just means that the
> swap pages are then kept track of, so that they can be aged along with
> other stores.

Problem still exists and persists. Not long time ago man from Yahoo
described well case when change from 2.2.19 to 2.4.x caused performance
problems. On 2.2.19 everything ran fine. They have MySQL running+did
backups from disk. After upgrade to 2.4.x MySQL performance felt down on
backup time. They investigated stuff and found that MySQL daemon gets
swapped out in the middle of usage to make room for buffers. In summary:
this made both sql and backup double slow. Even increasing memory from
1G->2G didn't helped. Finally they disabled swap at all and problem
lost.

If you do not want to change it back as it was in 2.2.x then would be
good if this is tunable somehow. 
 
-- 
For technical support contracts, goto https://order.mysql.com/
   __  ___     ___ ____  __
  /  |/  /_ __/ __/ __ \/ /    Mr. Tonu Samuel <tonu@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__   MySQL AB, Security Administrator
/_/  /_/\_, /___/\___\_\___/   Hong Kong, China
       <___/   www.mysql.com

