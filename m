Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWF1BmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWF1BmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 21:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWF1BmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 21:42:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:3306 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932685AbWF1BmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 21:42:15 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@osdl.org>
cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Sam Ravnborg <sam@ravnborg.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer problem 
In-reply-to: Your message of "Tue, 27 Jun 2006 18:15:46 MST."
             <Pine.LNX.4.64.0606271807570.3927@g5.osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Jun 2006 11:42:13 +1000
Message-ID: <5920.1151458933@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds (on Tue, 27 Jun 2006 18:15:46 -0700 (PDT)) wrote:
>
>
>On Tue, 27 Jun 2006, Daniel Ritz wrote:
>>  
>>  # Default for not multi-part modules
>> -modname = $(basetarget)
>> +modname = $(basename $(basetarget))
>
>Is there some way to make it clear _what_ the suffix we expect to remove 
>actually is in GNU make? Ie the "shell" kind of "basename" logic.
>
>Ie, I'd personally be happier with a 
>
>	modname = $(basename $(basetarget) .mod)
>
>kind of thing (yeah, this obviously does _not_ work)

modname = $(patsubst %.mod,%,$(basetarget))

should do it (untested).

