Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbTEEVuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTEEVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:50:23 -0400
Received: from sleet.ispgateway.de ([62.67.200.125]:64471 "HELO
	sleet.ispgateway.de") by vger.kernel.org with SMTP id S261409AbTEEVuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:50:22 -0400
Message-ID: <3EB6DF9F.7050907@gmx.net>
Date: Tue, 06 May 2003 00:03:11 +0200
From: Thomas Heinz <thomasheinz@gmx.net>
Reply-To: Thomas Heinz <thomasheinz@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kmalloc alignment
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Does the following property hold for kmalloc (2.4.x)?

Allocating a memory block of size: PAGE_SIZE >= 2^i >= 32 (or 64)
returns an address which is at least 2^i bytes aligned.

I flew over the code and as far as I can see the slabs are allocated
via __get_free_pages which returns PAGE_SIZE bytes aligned memory.
Since each slab allocates only blocks of the same size the property
follows immeadiately.

True or not?

Thanks for your help.
BTW, please cc your reply to my private e-mail since I'm currently
not subscribed.


Regards,

Thomas

