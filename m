Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVKPQhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVKPQhR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKPQhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:37:17 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:42248 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030401AbVKPQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:37:15 -0500
To: spotter@cs.columbia.edu
CC: a1426z@gawab.com, torvalds@osdl.org, linuxram@us.ibm.com,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, rob@landley.net
In-reply-to: <1132149576.8155.23.camel@localhost.localdomain> (message from
	Shaya Potter on Wed, 16 Nov 2005 08:59:36 -0500)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <200511152129.04079.rob@landley.net>
	 <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
	 <200511160835.28636.a1426z@gawab.com>
	 <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu> <1132149576.8155.23.camel@localhost.localdomain>
Message-Id: <E1EcQG3-0004SQ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Nov 2005 17:35:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Shouldn't chroot jail you?
> > 
> > No, chroot should just change the root.
> > 
> > If you don't want to be able to get back the old root, just close all
> > file descriptors _in addition_ to chroot() and chdir().
> 
> hah.  As long as you're running as root, chroot() again to a directory
> below you, and you effectively broken the chroot and can make a relative
> path to the old root. :)

... AND do 'setuid(nonroot)'.  Root can get out of a chroot() jail in
much more interesting ways.

Miklos
