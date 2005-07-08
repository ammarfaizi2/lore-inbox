Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVGHAHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVGHAHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVGHAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 20:07:48 -0400
Received: from [202.136.32.45] ([202.136.32.45]:2277 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262335AbVGHAHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 20:07:45 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <axboe@suse.de>, Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?=20Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Date: Fri, 08 Jul 2005 10:06:43 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <koerc1h7m0iri2pdrvsa0pu2tjakobq78o@4ax.com>
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <42CDAD94.7000306@rtr.ca>
In-Reply-To: <42CDAD94.7000306@rtr.ca>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jul 2005 18:32:52 -0400, Mark Lord <liml@rtr.ca> wrote:
>
>hdparm can also use O_DIRECT for the -t timing test.

I've not been able to get dual channel I/O speed faster than single 
interface speed, either as 'md' RAID0 or simultaneous reading or 
writing done the other day:

Time to write or read 500MB file:

>summary		2.4.31-hf1	2.6.12.2
>boxen \ time ->	 w 	 r	 w	 r
>---------------	----	----	----	----
...
>peetoo			33	20	26.5	22
>(simultaneuous		57	37.5	52	38.5)

MB/s		2.4.31-hf1	2.6.12.2
		w	r	w	r
single		15	25	19	23
dual		17.5	27	19	26

These timings show very little happening in parallel, is that normal?

Thanks,
--Grant.

