Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTDHTvC (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTDHTvC (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:51:02 -0400
Received: from trained-monkey.org ([209.217.122.11]:46084 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S261684AbTDHTvB (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:51:01 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Hicks <mort@bork.org>, linux-kernel@vger.kernel.org, hpa@zytor.com,
       wildos@sgi.com
Subject: Re: [patch] printk subsystems
References: <20030407201337.GE28468@bork.org>
	<20030408184109.GA226@elf.ucw.cz>
From: Jes Sorensen <jes@wildopensource.com>
Date: 08 Apr 2003 16:02:35 -0400
In-Reply-To: <20030408184109.GA226@elf.ucw.cz>
Message-ID: <m3k7e4ycys.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

>> Basically, each printk is assigned to a subsystem and that
>> subsystem has the same set of values that the console_printk array
>> has.  The difference is that the console_printk loglevel decides if
>> the message goes to the console whereas the subsystem loglevel
>> decides if that message goes to the log at all.

Pavel> Well, I consider this stop gap too... Right solution is to kill
Pavel> printk()s from too verbose part so that it does not
Pavel> overflow....

Hi Pavel,

Killing the printk's means they are not around if you have an end user
who is running into problems at boot time. Having a feature like this
means they can default to 'off' then if a problem arises, whoever is
doing the support can ask the user to try and enable printk's for say
SCSI and get the input, without haven to rebuild the kernel from
scratch.

For people supporting large numbers of users (like all the
distributions) this seems like a good win to me.

Cheers,
Jes
