Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbVBCJJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbVBCJJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 04:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVBCJJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 04:09:45 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:24713 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262478AbVBCJJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:09:31 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, kernel-janitors@osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: driver model u32 -> pm_message_t conversion: help needed
References: <20050125194710.GA1711@elf.ucw.cz>
	<yq0brb3qs74.fsf@jaguar.mkp.net> <20050202095014.GA12955@elf.ucw.cz>
	<20050202095739.GB12955@elf.ucw.cz>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Feb 2005 04:09:30 -0500
In-Reply-To: <20050202095739.GB12955@elf.ucw.cz>
Message-ID: <yq0y8e6ovqt.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

>> > Sorry for being late responding to this, but I'd say this is a
>> prime > example for typedef's considered evil (see Greg's OLS talk
>> ;).
>> > 
>> > It would be a lot cleaner if it was made a struct and then
>> passing a > struct pointer as the argument instead of passing the
>> struct by value > as you do right now.
>> 
>> Sorry, can't do that. That would require flag day and change
>> everything at once. That is just not feasible. When things are
>> settled, it is okay to change it to struct passed by value.. It is
>> small anyway and at least we will not have problems with freeing it
>> etc.

Pavel> Well, we could switch to passing struct by reference

Pavel> (typedef struct pm_message *pm_message_t)

Pavel> , but AFAICS it would only bring us problems with lifetime
Pavel> rules etc. Lets not do it.  Pavel

This way you end up hiding what is really going on, the very problem
of using typedefs. If the change is really needed why not get it right
in the first go?

Cheers,
Jes

