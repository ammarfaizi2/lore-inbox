Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267927AbUGaJic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267927AbUGaJic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUGaJib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:38:31 -0400
Received: from mail.euroweb.hu ([193.226.220.4]:45965 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S267927AbUGaJgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:36:19 -0400
To: smfrench@austin.rr.com
CC: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <1091244841.2742.8.camel@smfhome1.smfdom> (message from Steve
	French on Fri, 30 Jul 2004 22:34:01 -0500)
Subject: Re: uid of user who mounts
References: <1091239509.3894.11.camel@smfhome.smfdom>
	 <20040730190825.7a447429.rddunlap@osdl.org> <1091244841.2742.8.camel@smfhome1.smfdom>
Message-Id: <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 31 Jul 2004 11:35:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Steve French wrote:
> 
> Thanks - I had missed that - and it is a little cleaner to call it
> "user" than "mount_uid" in the line in /proc/mounts, and there are no
> existing parms returned that are similar (except "username" which should
> be easy enough to understand). Interestingly I did not see other
> filesystems returning that in /proc/mounts (I slightly prefer having it
> stored in the filesystems kernel code and returned in showopts not just
> put by userspace in the file mtab) - the only minor annoyance is that /
> etc/mtab returns the username (rather than the uid).

I support adding 'user=UID' to the /proc/mounts output.  Actually I
have an older patch which contains this feature.  This is slightly big
patch which also deals with completely elliminating the need for a
suid mount program for some specific filesystems.  See:

http://marc.theaimsgroup.com/?l=linux-fsdevel&m=108116200509753&w=2

Miklos
