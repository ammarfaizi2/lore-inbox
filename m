Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbUKRIAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbUKRIAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUKRIAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:00:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261750AbUKRIAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:00:01 -0500
Date: Thu, 18 Nov 2004 02:59:43 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
cc: netdev@oss.sgi.com, Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <419C4E72.5050307@blueyonder.co.uk>
Message-ID: <Xine.LNX.4.44.0411180257300.3144-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Ross Kendall Axe wrote:

> That seems eminently sensible. Again, I was just cut-n'-pasting from
> SOCK_STREAM. If these error codes are wrong, then SOCK_STREAM also needs
> fixing.

An issue here though is that what impact will this have on existing 
applications?

> > 
> > There is a non SELinux-related bug lurking in this code.
> 
> IMHO, there never was an SELinux bug here. SELinux merely exposed an 
> existing bug.

Looks like it, testing a fix now.

> I'm unable to reproduce that, or the bug you mention in your other 
> message. Care to send us your code?

See http://people.redhat.com/jmorris/net/seqpacket-killer-jm.tar.bz2 

> I think that af_unix.c needs a bit of cleaning up. All of the functions 
> are named as being stream vs dgram, even when the issue is connectionless 
> vs connection-oriented.

Agreed.


- James
-- 
James Morris
<jmorris@redhat.com>


