Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUGaTMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUGaTMF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 15:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUGaTMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 15:12:05 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:46091 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261300AbUGaTMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 15:12:02 -0400
Date: Sat, 31 Jul 2004 21:11:55 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Steve French <smfrench@austin.rr.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: uid of user who mounts
Message-ID: <20040731191155.GB5479@pclin040.win.tue.nl>
References: <1091239509.3894.11.camel@smfhome.smfdom> <20040730190825.7a447429.rddunlap@osdl.org> <1091244841.2742.8.camel@smfhome1.smfdom> <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu> <1091287308.2337.6.camel@smfhome.smfdom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091287308.2337.6.camel@smfhome.smfdom>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 10:21:48AM -0500, Steve French wrote:

> I confirmed what Randy had mantioned about the user= entries in mtab
> allowing umounts (at least it works that way for a few of the local
> filesystems I tried) but did not seem to work so well on other
> filesystems - I had odd results on umounting my cifs mounts e.g. - after
> adding at mount time "user=someuser" to /etc/mtab (by a minor change to
> the mount helper mount.cifs.c, when running mount.cifs suid).  umount of
> those mounts failed and has been tricky to debug through a privately
> built version of umount via ddd (although it is clearly not making it
> down to the cifs filesystem on the user umount so the problem is in libc
> or in fs/namespace.c) - so I am tracing through fs/namespace.c now.

This discussion sounds as if you do think that this is somehow kernel-related.
But it is not. Mount is suid and does certain things in a certain way.
For filesystems that have their own private mount program, that private
mount program is responsible for what happens.

Andries
