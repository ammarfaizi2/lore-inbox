Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWCKBhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWCKBhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWCKBhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:37:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12549 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932366AbWCKBhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:37:22 -0500
Date: Sat, 11 Mar 2006 02:37:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: maintainers@chelsio.com
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: drivers/net/chelsio/sge.c: two array overflows
Message-ID: <20060311013720.GG21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following two array overflows in 
drivers/net/chelsio/sge.c (in both cases, the arrays contain 3 elements):

<--  snip  -->

...
static void restart_tx_queues(struct sge *sge)
{
...
                                sge->stats.cmdQ_restarted[3]++;
...
static int t1_sge_tx(struct sk_buff *skb, struct adapter *adapter,
                     unsigned int qid, struct net_device *dev)
{
...
                        sge->stats.cmdQ_full[3]++;
...

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

