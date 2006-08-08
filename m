Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWHHRwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWHHRwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWHHRwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:52:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20416 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030211AbWHHRwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:52:42 -0400
Subject: Re: How to lock current->signal->tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       davem@redhat.com, jack@suse.cz, dwmw2@infradead.org,
       tony.luck@intel.com, jdike@karaya.com,
       James.Bottomley@HansenPartnership.com
In-Reply-To: <1155059046.1123.120.camel@moss-spartans.epoch.ncsc.mil>
References: <1155050242.5729.88.camel@localhost.localdomain>
	 <1155057114.1123.97.camel@moss-spartans.epoch.ncsc.mil>
	 <1155058994.5729.99.camel@localhost.localdomain>
	 <1155059046.1123.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 19:10:11 +0100
Message-Id: <1155060611.5729.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-08 am 13:44 -0400, ysgrifennodd Stephen Smalley:
> SELinux is just revalidating access to the tty when the task changes
> contexts upon execve, and resetting the tty if the task is no longer
> allowed to use it.  Likewise with the open file descriptors that would
> be inherited.  No clearing of the ttys of other tasks required as far as
> SELinux is concerned, although that might not fit with normal semantics.

The kernel requires you end up with a session leader etc so an exec that
loses rights by the session leader does indeed match disassociate_ctty I
guess. The ctty is a bit of an odd thing in the Unix world and perhaps
something that shouldn't have happened in that it gives you ability to
do things even if you have no fd to it.

Alan

