Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTDQOi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTDQOiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:38:22 -0400
Received: from 217-126-36-165.uc.nombres.ttd.es ([217.126.36.165]:45516 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S261595AbTDQOhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:37:39 -0400
Date: Thu, 17 Apr 2003 16:47:35 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, <jlnance@unity.ncsu.edu>
Subject: Re: RedHat 9 and 2.5.x support
In-Reply-To: <20030417142356.GA7195@ncsu.edu>
Message-ID: <Pine.LNX.4.44.0304171642510.30694-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 jlnance@unity.ncsu.edu wrote:

> I have a related question.  While I am confident I can get RH9 to work
> with a 2.5 kernel, I would like to do this in such a way that booting
> into a 2.4 kernel still works, and installing updated 2.4 kernel RPMs
> from Red Hat also continues to work.  I would also like to avoid making
> any changes that prevent me from upgrading to the next RH release.  I
> assume I can accomplish this by only making changes that involve installing
> rpms rather than installing programs directly.  I am not confident I can 
> accomplish all this, having failed in my attempt with RH8 :-)
	
* ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modutils-2.4.21-18.src.rpm
* rpmbuild --rebuild modutils-2.4.21-18.src.rpm
* rpm -Uvh modutils-2.4.21-18.i386.rpm
* add the new kernel to /boot/grub/grub.conf

# vi /etc/rc.d/rc.sysinit 
:360,360s/ksyms/modules/g
:wq

You are done.
Pau

