Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbVLFOBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVLFOBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVLFOBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:01:52 -0500
Received: from mail.enyo.de ([212.9.189.167]:57752 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932559AbVLFOBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:01:51 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <200512060110.jB61AMHF004027@pincoya.inf.utfsm.cl>
Date: Tue, 06 Dec 2005 15:01:20 +0100
In-Reply-To: <200512060110.jB61AMHF004027@pincoya.inf.utfsm.cl> (Horst von
	Brand's message of "Mon, 05 Dec 2005 22:10:22 -0300")
Message-ID: <8764q2qq8f.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Horst von Brand:

>> You mentioned security issues in your initial post.  I think it would
>> help immensely if security bugs would be documented properly (affected
>> versions, configuration requirements, attack range, loss type etc.)
>> when the bug is fixed, by someone who is familiar with the code.
>> (Currently, this information is scraped together mostly by security
>> folks, sometimes after considerable time has passed.)  Having a
>> central repository with this kind of information would enable vendors
>> and not-quite-vendors (people who have their own set of kernels for
>> their machines) to address more vulnerabilties promptly, including
>> less critical ones.
>
> I've fixed bugs which turned out to be security vulnerabilities. And I
> didn't know (or even care much) at the time. Finding out if some random bug
> has security implications, and exactly which ones/how much of a risk they
> pose is normally /much/ harder than to fix the bugs.

I know, it happens all the time: vulnerabilities are fixed because
they are bugs, and not because they are vulnerabilities.  It's
unfortunate if people are unnecessarily exposed to the vulnerability
(because they don't know about it and don't apply the fix as a result),
but it's better than carrying around the bug indefinitely.

But if there's considerable evidence that you might have fixed a
security bug, preserving this information (and other bits that are
immediately obvious to you as a developer, but not necessarily who
reviews the issue) seems worthwhile.  Maybe you don't want to put it
into the public commit message, but forwarding what you have to some
trusted group of volunteers would make sense.  The volunteers would
distill the information, add more data and assign a CVE if necessary,
and declassify the information as soon as the public is ready (in the
form of a short security advisory, like the ones you see for most
applications).

Does this sound too far-fetched?  Why don't you think this would be a
valuable service to all users, vanilla kernels or not?

> And rather pointless, after the fix is in.

It doesn't matter much if the fix is in the kernel.org tree, when I'm
supposed to use vendor kernels. 8-)
