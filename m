Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269191AbUINIZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbUINIZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUINIZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:25:27 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:51728 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S269191AbUINIZS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:25:18 -0400
Date: Tue, 14 Sep 2004 16:25:33 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Mitch Sako <msako@cadence.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: autofs4 /net /proc/mounts problem
In-Reply-To: <6.1.2.0.2.20040913092535.0d1d5aa0@mailhub>
Message-ID: <Pine.LNX.4.58.0409141623440.27621@wombat.indigo.net.au>
References: <6.1.2.0.2.20040913092535.0d1d5aa0@mailhub>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-102.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Mitch Sako wrote:

> I’m seeing the following situation occur with 2.4.23 up through 2.4.27 and 
> autofs 4.1.3 using /net access with a generic /etc/auto.net.  I tried 
> 'nonstrict' and 'nosymlink' in /etc/auto.net but that resulted in the 
> mounts not working.
> 
> NFS Server foo has virtual nested exports:
> / on /dev/sda1
> /bar on /dev/sdb1 (for example)
> 
> cd /net/foo/bar mounts both / and /bar which it finds from ‘showmount –e’
> 
> df shows foo:/ and foo:/bar mounted
> 
> /proc/mounts shows both, also.
> 
> I’m guessing what’s happening next is autofs4 tries to umount foo:/ before 
> foo:/bar which yields a busy condition for foo:/, even though it’s not 
> because foo:/bar is mounted above foo:/ on the client.
> 
> /proc/mounts starts filling up with foo:/bar entries at this point and 
> fills up the mount table.
> 
> If I bring down the automount process, manually go through and umount all 
> of the foo:/bar entries in /proc/mounts, clean up anything in /etc/mtab and 
> then restart the automounter, everything seems to be OK.  Obviously, this 
> is not acceptable.
> 
> Any ideas?

Are you using a kernel with the latest autofs4 patch?

btw the place for these questions is the autofs mailing list.

Ian

