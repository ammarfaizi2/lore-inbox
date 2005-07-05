Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVGEWzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVGEWzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVGEWzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:55:13 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:17933 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261990AbVGEWwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:52:50 -0400
Message-ID: <42CB0F22.5030609@slaphack.com>
Date: Tue, 05 Jul 2005 17:52:18 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl>	<42CB0A40.3070903@slaphack.com> <877jg4an70.fsf@jbms.ath.cx>
In-Reply-To: <877jg4an70.fsf@jbms.ath.cx>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Maitin-Shepard wrote:
> David Masover <ninja@slaphack.com> writes:
> 
> [snip]
> 
> 
>>>I have. And have seen /no/ benefit to you. Except, of course, the benefit
>>>accrued from some magic in Linus' kernel, by which all format differences
>>>go in a puff of smoke if they are implemented inside it, and furthermore
>>>all userland gets rebuilt to use the kernel's way overnight.
> 
> 
>>Let's say cryptocompress gets implemented.  Not all of userland
>>rewritten, not even any of userland rewritten, just a cryptocompress
>>plugin for the kernel.  And instead of having to learn a new tool, I can
>>just browse around in /meta.
> 
> 
> What is the relationship between file-as-dir or special meta-data and
> transparent encryption+compression?  I do not see why file-as-dir would
> require such a special interface.

I'm ignoring file-as-dir until/unless someone figures out a sane way of
doing it.

Under Reiser4, think of all files/directories as objects.  Meta-data, as
accessed through file-as-dir or through /meta, is just a collection of
methods to that file/directory.  Some methods are just accessor
(setter/getter) methods, like foo.mp3/artist -- they are effectively
attributes, although there may be a little more logic going on there
(foo.mp3/artist probably is connected to foo.mp3's id3 tag).  Some
methods actually do something, like secret.txt/compression.

The reason I'm bringing that up is that some people seem determined to
keep the very concept out of the kernel because it's new, strange, and
doesn't seem to have any real applications.  I want it in because it has
real, fairly immediate applications, and much bigger payoffs down the
road, and I don't think it's that strange -- it's a nice, clean design.
