Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWIEQwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWIEQwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWIEQw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:52:29 -0400
Received: from [81.2.110.250] ([81.2.110.250]:37258 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030196AbWIEQw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:52:28 -0400
Subject: Re: Kernel drops ethernet packets during disk writes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tiemen Schut <tschut@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <86b122f40609050906u7aafe808h5002c9f15369a744@mail.gmail.com>
References: <86b122f40609050815v664ff217kcfc82a5c9f2772ad@mail.gmail.com>
	 <86b122f40609050906u7aafe808h5002c9f15369a744@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Sep 2006 18:15:12 +0100
Message-Id: <1157476512.9018.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-05 am 18:06 +0200, ysgrifennodd Tiemen Schut:
> Summary: The linux kernel appears to drop raw ethernet packets if
> another process is writing to disk.

No suprise. 

1Gbit is a bit over 100Mbyte/second

Thats from the card over PCI to memory
Then over PCI from memory to the disk controller

We are up to 200Mbytes/second

Best case performance for a 32bit PCI bus is 133Mbytes/second and you
won't get close to that. Even if both devices are PCI 66Mhz you are
right on the bus limit.

And if its an earlyish PIV what is your main memory bandwidth ?

