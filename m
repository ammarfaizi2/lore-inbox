Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUBXAWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUBXAWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:22:42 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:62130 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261653AbUBXAWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:22:39 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 24 Feb 2004 11:22:37 +1100
Cc: Ia64 Linux <linux-ia64@vger.kernel.org>
Subject: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2GB
Message-ID: <20040224002237.GE8906@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Ia64 Itanium 1 machines with more than 2.5GB of RAM the follwing error is triggered.
 
slab error in check_poison_obj(): cache `size-16384': object was modified after freeing

The machine that triggered the error above is an

i2000 HP workstation
4gb RAM
1gb SWAP

An identical machine with 2.5GB ram produces:

slab error in check_poison_obj(): cache `size-2048': object was modified after freeing

if the amount of RAM is reduced to 2GB or less then the errors do not appear.

Kernel logs and configs can be found at:
http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/


--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
