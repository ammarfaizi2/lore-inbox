Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270386AbTGWQFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270391AbTGWQFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:05:09 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:49913 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270386AbTGWQFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:05:06 -0400
Subject: Re: kernel bug in socketpair()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: dgk@research.att.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gsf@research.att.com, netdev@oss.sgi.com
In-Reply-To: <20030723083621.26429e51.davem@redhat.com>
References: <200307231332.JAA26197@raptor.research.att.com>
	 <1058970007.5520.68.camel@dhcp22.swansea.linux.org.uk>
	 <20030723083621.26429e51.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058976818.5520.91.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 17:13:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 16:36, David S. Miller wrote:
> > This is intentional - sockets do not have an "open" operation currently.
> 
> Sure, but we've known this for a long time.
> 
> And because we knew, we decided not to add an "open"
> method to sockets.  The reason, as I remember it, was
> security.
> 
> Was it not?

Mostly if I remember rightly that if you don't do the check because you have
no open operation to create a new instance you crash the box. HPA did have 
some sensible ideas about how to do "open" on AF_UNIX sockets but for the 
others its really unclear quite what "open" means

