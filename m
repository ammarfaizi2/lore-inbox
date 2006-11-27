Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758534AbWK0SyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758534AbWK0SyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758535AbWK0SyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:54:25 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:63041 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1758534AbWK0SyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:54:24 -0500
Message-ID: <456B3483.4010704@cfl.rr.com>
Date: Mon, 27 Nov 2006 13:54:59 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
CC: G.Ohrner@post.rwth-aachen.de, linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr> <ek54hf$icj$2@sea.gmane.org> <456B0F53.90209@cfl.rr.com> <456B101D.3040803@nortel.com>
In-Reply-To: <456B101D.3040803@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Nov 2006 18:54:36.0046 (UTC) FILETIME=[7BB702E0:01C71255]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14838.003
X-TM-AS-Result: No--12.850900-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> I believe the idea was that you don't want random users being able to 
> artificially inflate your entropy count.  So the kernel tries to make 
> use of entropy entered by regular users (by stirring it into the pool) 
> but it doesn't increase the entropy estimate unless root says its okay.

Why are non root users allowed write access in the first place?  Can't 
the pollute the entropy pool and thus actually REDUCE the amount of good 
entropy?  It seems to me that only root should have write access in the 
first place because of this, and thus, anything root writes should 
increase the entropy count since one can assume that root is supplying 
good random data for the purpose of increasing the entropy count.

I was planning on just setting up a little root cron script to pull some 
random data from another machine on the network to add to the local 
pool, then push some random data back to the other machine to increase 
its pool, but found that this doesn't work due to this restriction.

