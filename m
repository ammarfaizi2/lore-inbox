Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbVKSDf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbVKSDf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbVKSDf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:35:27 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:9228 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1161258AbVKSDf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:35:27 -0500
Date: Sat, 19 Nov 2005 11:35:02 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Olivier Croquette <ocroquette@free.fr>
cc: LKML <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: Automount ghost option
In-Reply-To: <437E0F3A.2000906@free.fr>
Message-ID: <Pine.LNX.4.63.0511191116260.2069@donald.themaw.net>
References: <437E0F3A.2000906@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Olivier Croquette wrote:

> 
> I want the automount mount points to be visible even if they are not mounted.
> 
> It seems the "ghost" option implements that. I can find several references on
> the internet which indicates it is available, like:
> http://gentoo-wiki.com/HOWTO_Auto_mount_filesystems_(AUTOFS)

This looks like a good description of to do it.

> 
> Nevertheless, on some recent distributions I have tested on, this option is
> not available.

For example?

It is available on all recent RedHat distributions, Debian 3.1, latest 
SuSE and although last time I looked Gentoo is a little behind on their 
release and patches it should still work. I also recommend a fairly recent 
2.6 kernel in order to get the latest bug fixes. I've fallen somewhat 
behind in updating my 2.4 patches but those that are available at 

http://www.kernel.org/pub/linux/daemons/autofs/v4

should work adequately.

> 
> Can anyone tell me in which version of automount it is present?
> Or is it a distribution specific patch?

Preferably 4.1.4 with at least the patches autofs-4.1.4-*.patch from 
kernel.org above applied but distributions that have a 4.1 version should 
work.

You need to be aware that some maps cannot be browsable (the terminology 
is about to change from ghosting). For example

*	host:/some/dir/&

is not browsable because autofs cannot know what the map keys at startup.

Basically, if the map keys cannot be known in advance they will not be 
seen, at least immediately after startup.
 
Ian

