Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268937AbTCARNI>; Sat, 1 Mar 2003 12:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268938AbTCARNI>; Sat, 1 Mar 2003 12:13:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54031 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268937AbTCARNE>;
	Sat, 1 Mar 2003 12:13:04 -0500
Message-ID: <3E60EC7D.2040802@pobox.com>
Date: Sat, 01 Mar 2003 12:23:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix warning in drivers/net/sis900.c
References: <51890000.1046538667@[10.10.2.4]>
In-Reply-To: <51890000.1046538667@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> drivers/net/sis900.c: In function `set_rx_mode':
> drivers/net/sis900.c:2100: warning: passing arg 2 of `set_bit' from incompatible pointer type
> 
> I just cast this. Seems to work fine at the moment, so presumably it's
> correct.


Nope -- set_bit wants to work on a real unsigned long.  While your patch 
will work, the proper fix is to not use set_bit :)

	Jeff



