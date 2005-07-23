Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVGWT3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVGWT3B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVGWT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:29:00 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:1497 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261807AbVGWT2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:28:03 -0400
Subject: Re: kernel optimization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: cutaway@bellsouth.net
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <01bd01c58f50$0998c650$2800000a@pc365dualp2>
References: <42E14134.1040804@yahoo.co.uk> <20050722201416.GM3160@stusta.de>
	 <01bd01c58f50$0998c650$2800000a@pc365dualp2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 23 Jul 2005 20:50:36 +0100
Message-Id: <1122148237.27629.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-07-23 at 02:30 -0400, cutaway@bellsouth.net wrote:
> Larger does not always mean slower.  If it did, nobody would implement a
> loop unrolling optimization.

Generally speaking nowdays it does. Almost all loop unrolls are a loss
on PIV.

> ex. Look at how GCC generates jump tables for switch() when there's about
> 10-12 (or more) case's sparsely scattered in the rage from 0 through 255.

You are comparing with very expensive jump operations its an unusual
case. For the majority of situations the TLB/cache overhead of misses
vastly outweighs the odd clock cycle gained by verbose output.


