Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbULQFsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbULQFsT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 00:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbULQFsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 00:48:19 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:63978 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262749AbULQFsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 00:48:15 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: debugfs in the namespace
To: Greg KH <greg@kroah.com>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 17 Dec 2004 06:51:11 +0100
References: <fa.al1ango.pl0rak@ifi.uio.no> <fa.ddml8me.1k46obg@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1CfB1D-00011J-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Dec 16, 2004 at 04:51:18PM -0500, Mike Waychison wrote:

>> Please, let's not make debugfs part of userspace.  Keep it for what it
>> is, debugging purposes only.
> 
> I'm not saying we will ever make it "required" at all.  It's just that
> people are going to want to mount the thing, and are already asking me
> where we should mount it at.  If you pick a different place than me,
> fine, I don't mind.  It's the user who is asked to report some info that
> happens to be in debugfs that is going to want to know where to put it,
> as they have no idea even what it is.  Distros are going to ask what to
> put in their fstabs for where to mount the thing too.
> 
> So, let's pick a place and be done with it.

/mnt (users) or /var/adm/mount/debugfs (distros, asuming they mount their
temporary stuff there).

I'm asuming you should almost never need to touch devfs-entries, so if
your distro mounts it just in case, it should be out of the way.

