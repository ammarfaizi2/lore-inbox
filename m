Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWBNAUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWBNAUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWBNAUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:20:36 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:19634
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030329AbWBNAUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:20:35 -0500
Message-ID: <43F12248.7070608@microgate.com>
Date: Mon, 13 Feb 2006 18:20:24 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Fulghum <paulkf@microgate.com>
CC: Jason Baron <jbaron@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "jesper.juhl@gmail.com" <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty reference count fix
References: <1139861610.3573.24.camel@amdx2.microgate.com> <Pine.LNX.4.61.0602131747570.19384@dhcp83-105.boston.redhat.com> <43F119FC.10900@microgate.com>
In-Reply-To: <43F119FC.10900@microgate.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> Your patch leaves the schedule() call at the bottom of
> the while loop between setting tty_closing and
> setting TTY_CLOSING flag.

Nevermind. After schedule() the count is reread,
so you are right. Dropping tty_sem altogether
would work.

It is a matter of where you ultimately wish to
push the locking to BKL or tty_sem.

-- 
Paul Fulghum
Microgate Systems, Ltd
