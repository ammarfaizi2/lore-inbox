Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTDHVtP (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTDHVtP (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:49:15 -0400
Received: from trained-monkey.org ([209.217.122.11]:62724 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S261866AbTDHVtO (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:49:14 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Martin Hicks <mort@bork.org>, linux-kernel@vger.kernel.org, hpa@zytor.com,
       wildos@sgi.com
Subject: Re: [patch] printk subsystems
References: <20030407201337.GE28468@bork.org>
	<20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org>
	<20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
From: Jes Sorensen <jes@wildopensource.com>
Date: 08 Apr 2003 18:00:49 -0400
In-Reply-To: <20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
Message-ID: <m3fzosy7hq.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Hi!
>> Killing the printk's means they are not around if you have an end
>> user who is running into problems at boot time. Having a feature
>> like this means they can default to 'off' then if a problem arises,
>> whoever is doing the support can ask the user to try and enable
>> printk's for say SCSI and get the input, without haven to rebuild
>> the kernel from scratch.

Pavel> Well, I think we should first kill all crappy messages -- that
Pavel> benefits everyone. I believe that if we kill all unneccessary
Pavel> (carrying no information except perhaps copyright or
Pavel> advertising) will help current problem a lot.

I agree that some messages can be eliminated, but not all of
them. Even some of the ones you suggested might be valuable to keep,
like the CPU flags. Generally this isn't a problem on a small box with
2 CPUs and 2 disks, but if you have 32 CPUs and 64 SCSI disks, the
amount of data being printed becomes quite substantial.

So while I agree that it wouldn't hurt for us to eliminate some
unncessary printk's, then I still think Martin's patch has a lot of
merit.

Cheers,
Jes
