Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTKZUD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTKZUD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:03:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:49046 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264296AbTKZUDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:03:55 -0500
Date: Wed, 26 Nov 2003 12:03:16 -0800
From: "David S. Miller" <davem@redhat.com>
To: Paul Menage <menage@google.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126120316.3ee1d251.davem@redhat.com>
In-Reply-To: <3FC505F4.2010006@google.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<3FC505F4.2010006@google.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 11:58:44 -0800
Paul Menage <menage@google.com> wrote:

> How about tracking the number of current sockets that have had timestamp 
> requests for them? If this number is zero, don't bother with the 
> timestamps. The first time you get a SIOCGSTAMP ioctl on a given socket, 
> bump the count and set a flag; decrement the count when the socket is 
> destroyed if the flag is set.

Reread what I said please, the user can ask for timestamps using CMSG
objects via the recvmsg() system call, there are no ioctls or socket
controls done on the socket.  It is completely dynamic and
unpredictable.
