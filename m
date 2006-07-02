Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWGED7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWGED7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 23:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWGED7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 23:59:47 -0400
Received: from smtpout.mac.com ([17.250.248.186]:41979 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932370AbWGED7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 23:59:46 -0400
In-Reply-To: <5920.1151458933@kao2.melbourne.sgi.com>
References: <5920.1151458933@kao2.melbourne.sgi.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3395E475-11A9-492A-91DE-EEA88ACE16E9@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Sam Ravnborg <sam@ravnborg.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: oom-killer problem
Date: Sun, 2 Jul 2006 14:12:28 -0400
To: Keith Owens <kaos@ocs.com.au>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 27, 2006, at 21:42:13, Keith Owens wrote:
> Linus Torvalds (on Tue, 27 Jun 2006 18:15:46 -0700 (PDT)) wrote:
>> Ie, I'd personally be happier with a
>>
>> 	modname = $(basename $(basetarget) .mod)
>>
>> kind of thing (yeah, this obviously does _not_ work)
>
> modname = $(patsubst %.mod,%,$(basetarget))

Sorry to come in so late on this; this email's been sitting in my  
outbox for a week.  Here's a mildly simpler alternative:

modname = $(basetarget:.mod=)

A slightly more flexible alternative:

modname = $(basetarget:%.mod=%)

Cheers,
Kyle Moffett

