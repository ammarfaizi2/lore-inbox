Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVKPKPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVKPKPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbVKPKPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:15:43 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:47370 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932596AbVKPKPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:15:42 -0500
To: rob@landley.net
CC: a1426z@gawab.com, torvalds@osdl.org, linuxram@us.ibm.com,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <200511160310.24807.rob@landley.net> (message from Rob Landley on
	Wed, 16 Nov 2005 03:10:24 -0600)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <200511160835.28636.a1426z@gawab.com> <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu> <200511160310.24807.rob@landley.net>
Message-Id: <E1EcKJe-0005ll-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Nov 2005 11:14:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you don't want to be able to get back the old root, just close all
> > file descriptors _in addition_ to chroot() and chdir().
> 
> If you try the chdir by filedescriptor trick on the stdin/stdout/stderr fed 
> into PID 1 when it's started up by the kernel, which filesystem do you wind 
> up in?  (rootfs?)

You can't fchdir() to a non-directory, so this shouldn't be an issue.

Miklos
