Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUCPUqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUCPUqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:46:07 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:32916 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261652AbUCPUqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:46:00 -0500
Date: Tue, 16 Mar 2004 21:45:34 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs
Message-ID: <20040316204534.GB22482@wohnheim.fh-wedel.de>
References: <20040316180413.GA22482@wohnheim.fh-wedel.de> <200403161940.i2GJeP6m007930@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200403161940.i2GJeP6m007930@eeyore.valparaiso.cl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 March 2004 15:40:24 -0400, Horst von Brand wrote:
> > 
> > $ cp -cr dir1 dir2
> > 
> > Behaves similar to 'cp -lr', but creates COWs instead of hard links.
> > Can take a few seconds to create the directories, but not minutes.
> 
> Why does it magically take less time? The work done (recursing, fiddling
> with directories, syscalls, ...) is nearly the same.

joern@limerick:~$ time cp -lr /usr/src/linux/ /tmp/linux

real    0m22.356s
user    0m0.167s
sys     0m1.480s
joern@limerick:~$ rm -r /tmp/linux/
joern@limerick:~$ time cp -r /usr/src/linux/ /tmp/linux

real    1m44.147s
user    0m0.499s
sys     0m7.987s

'nuf said, eot.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
