Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVJDK4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVJDK4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 06:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJDK4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 06:56:46 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:25362 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751218AbVJDK4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 06:56:45 -0400
To: aia21@cam.ac.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <1128421880.3785.0.camel@imp.csi.cam.ac.uk> (message from Anton
	Altaparmakov on Tue, 04 Oct 2005 11:31:19 +0100)
Subject: Re: [PATCH 2.6] Do not set ATTR_CTIME in do_truncate(). - was: Re:
	truncate(2) sometimes updates ctime and sometimes ctime and mtime!
References: <1128092687.5715.12.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.64.0509300823160.3378@g5.osdl.org>
	 <1128095994.3584.12.camel@imp.csi.cam.ac.uk> <1128421880.3785.0.camel@imp.csi.cam.ac.uk>
Message-Id: <E1EMkSN-00081A-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 04 Oct 2005 12:55:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a (tested) patch to remove the setting of ATTR_CTIME in
> do_truncate() as you suggested.

This is still inconsistent: all other "setattr" operations (chmod,
chown, chgrp, utime) still set ATTR_CTIME.

I think either ATTR_CTIME should be implicit in ->setattr() in which
case you should remove it in all those cases, or leave it as it is.

Miklos
