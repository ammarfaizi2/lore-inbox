Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUBTOH7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 09:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUBTOEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 09:04:12 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:5022 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261202AbUBTOBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 09:01:00 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
Date: Fri, 20 Feb 2004 14:55:25 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402201455.25782.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:

> +
> +struct mq_attr {
> +	long	mq_flags;	/* message queue flags			*/
> +	long	mq_maxmsg;	/* maximum number of messages		*/
> +	long	mq_msgsize;	/* maximum message size			*/
> +	long	mq_curmsgs;	/* number of messages currently queued	*/
> +};
> +

Does POSIX mandate that these have to be 'long'? If you can change them
all to any of 'int', '__s32' or '__s64', the handlers for 32 bit system
call emulation on 64 bit machines will get a lot simpler because the
32 bit user structures are then identical to the 64 bit ones.

	Arnd <><

