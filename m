Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVHJOiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVHJOiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVHJOiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:38:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:10378 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965133AbVHJOiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:38:24 -0400
Subject: Re: [PATCH] ide-disk oopses on boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Lameter <christoph@lameter.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       kiran@scalex86.org, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.62.0508091953270.30717@graphe.net>
References: <20050809132725.GA20397@vana.vc.cvut.cz>
	 <Pine.LNX.4.62.0508090926150.12719@graphe.net>
	 <42F92A1F.9040901@vc.cvut.cz>
	 <Pine.LNX.4.62.0508091953270.30717@graphe.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Aug 2005 16:04:57 +0100
Message-Id: <1123686298.28913.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-09 at 19:59 -0700, Christoph Lameter wrote:
> Yes you are right there is one additional place where pcibus_to_node is 
> used with the hwif that we did not cover. This better go into 2.6.13.

drive->hwif is not permitted to be NULL. Please work back and fix the
actual bug.

> 

