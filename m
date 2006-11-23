Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757486AbWKWVl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbWKWVl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757488AbWKWVl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:41:27 -0500
Received: from main.gmane.org ([80.91.229.2]:19852 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1757485AbWKWVl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:41:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: Entropy Pool Contents
Date: Thu, 23 Nov 2006 22:40:36 +0100
Message-ID: <ek54hf$icj$2@sea.gmane.org>
References: <ek2nva$vgk$1@sea.gmane.org> <Pine.LNX.4.61.0611230107240.26845@yvahk01.tjqt.qr>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e179249004.adsl.alicedsl.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>Hornburg:~# cat /proc/sys/kernel/random/entropy_avail
>>0
> You really must have bad luck with your entropy...

IMHO something really fishy's going on there. If I explicitely write data
into the pool, it shouldd not stay at "zero", from wwhat I understood about
how /dev/*random work.

> Disk activities are "somewhat predictable", like network traffic, and
> hence are not (or should not - have not checked it) contribute to the
> pool.

Well, they do, block device operations do, using the function
add_blkdev_randomness, as far as I know.

> Note that urandom is the device which _always_ gives you data, and 
> when the pool is exhausted, returns pseudorandom data.

I know, and running on deterministically computed random values only for
days in a row is no situation I'm paticularily happy about...

I'm mainly wondering why writing stuff to /dev/*random does not change the
entropy from zero to at least any low non-zero value...

Greetings,

  Gunter

