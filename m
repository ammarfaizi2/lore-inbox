Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTH1DSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 23:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTH1DSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 23:18:07 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:20415 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S263601AbTH1DSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 23:18:04 -0400
Date: Thu, 28 Aug 2003 06:17:46 +0300
Subject: Re: Lockless file reading
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: root@chaos.analogic.com, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
From: Timo Sirainen <tss@iki.fi>
In-Reply-To: <20030828015027.GA4715@mail.jlokier.co.uk>
Message-Id: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Aug 28, 2003, at 04:50 Europe/Helsinki, Jamie Lokier wrote:

>> 	checksum[0]++;
>> 	xor = buf[0] ^ checksum[0];
>
> Your algorithm isn't going to work if the new value of xor is the same
> as the old value of xor.

I was trying to prevent it with the checksum[0]++ .. but yes, you're 
right.

I'm sure someone has figured out a way to make a checksum of data that 
can detect if there's even a single bit wrong, if the checksum is 
allowed to take as much space as the data itself. I should read more 
about algorithms..

How about checksum[n] = data[n-1] ^ data[n]? That looks like it would 
work.

