Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbQKSNVh>; Sun, 19 Nov 2000 08:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbQKSNV1>; Sun, 19 Nov 2000 08:21:27 -0500
Received: from mail.zmailer.org ([194.252.70.162]:1804 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129717AbQKSNVQ>;
	Sun, 19 Nov 2000 08:21:16 -0500
Date: Sun, 19 Nov 2000 14:51:04 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: George Garvey <tmwg-linuxknl@inxservices.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is 2.4.0-test10: md1 has overlapping physical units with md2!
Message-ID: <20001119145104.O28963@mea-ext.zmailer.org>
In-Reply-To: <20001119033943.C935@inxservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001119033943.C935@inxservices.com>; from tmwg-linuxknl@inxservices.com on Sun, Nov 19, 2000 at 03:39:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 03:39:43AM -0800, George Garvey wrote:
> Is this something to be concerned about? It sounds like a disaster waiting
> to happen from the message. This is on 2 systems (with similar disk setups
> [same other than size]).

	Nothing to worry.  (I got worried also when I saw it the first time)

> Nov 18 16:31:02 mwg kernel: md: serializing resync,
	 md0 has overlapping physical units with md2!  

	It is perhaps poorly worded -- multiple MD "devices" using
	same physical devices, although they are not on overlapped
	partitions, do get that message.

	It means simply that if those two were running reconstruction
	simultaneously, they would cause seeking back&forth over the
	device.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
