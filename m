Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbTDQNlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 09:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTDQNlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 09:41:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13698 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261378AbTDQNlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 09:41:44 -0400
Date: Thu, 17 Apr 2003 09:55:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: joe briggs <jbriggs@briggsmedia.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Help with virus/hackers
In-Reply-To: <200304171015.13474.jbriggs@briggsmedia.com>
Message-ID: <Pine.LNX.4.53.0304170932490.15993@chaos>
References: <200304171015.13474.jbriggs@briggsmedia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, joe briggs wrote:

> Please redirect me if this is not the appropriate place for this post.
>
> I have several Debian/Woody/2.4.19 webserver/firewalls at various locations
> that seem to have been hacked or victum of a worm or virus.  It is hard to
> articulate exactly the symptoms since it quickly brings the system down, but
> here is what I know so far:
>
[SNIPPED...]

It is unlikely that one of those Windows worms or virii affected
your system. It is more likely that you simply have a trashed
file-system. To check for an invasion, do the following.

(1) Disconnect the network wire.
(2) Boot with init=/bin/bash
(3) `fsck` each file-system slice by hand. Look in /etc/fstab
     to get them all.
(4)  Execute `mount -a` to mount all the slices in the correct
     order.
(5)  Examine /etc/inetd.conf (if one exists). If you see an
     unusual entry near the end, you have been 'rooted'. Newer
     systems use xinetd and won't get invaded this way.
(6)  Check /etc/passwd for a strange account.
(7)  Check /bin/login for a new file-date.
(8)  Check /usr/sbin/sendmail for a new file-date.
     Check /usr/sbin/inetd      ""
     Check /usr/sbin/xinetd     ""
     Check /usr/sbin/syslogd    ""
     Check /usr/sbin/klogd      ""
     Check /usr/sbin/in.*       ""

If any of these files have recent writes, tar off all user-data
and completely install Linux again (from a distribution) from scratch.
Do not use a recent backup. It could have already been invaded.

If none of these have recent writes, just change the password on
the root account and be happy. You just has some file-system
corruption and you can fix up /etc/DIR_COLORS (for your color-ls
problem) and fix /etc/profile or /root/.bashrc, /root/.profile
to fix the bad environment variables created by these scripts.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

