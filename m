Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268791AbUILTDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268791AbUILTDm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268794AbUILTDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:03:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:28341 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268791AbUILTDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:03:40 -0400
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and
	REMOTE(verified)Denial of Service Attack
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: peter@mysql.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <002501c498f8$0a4ebc20$0200a8c0@wolf>
References: <002501c498f8$0a4ebc20$0200a8c0@wolf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095012081.11745.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 19:01:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 19:40, Wolfpaw - Dale Corse wrote:
> This bug also exists with Apache, the default config of SSH,
> and anything controlled by inetd. This is the vast majority of
> popular services on a regular internet server.. That is bad, no?

I'm unable to duplicate any such problems with xinetd, or with thttpd,
or with apache. Apache will wait a short time then timeout connections
if you've configured it right. If you can continue making millions of
connections a second you can DoS the server the other end, not exactly
new news. The alternative is that you have an infinite number of running
services and you run out of memory instead.

Thats a high level property of any protocol which allows commitment of
resource without being able to do the security authentication first. Its
very hard to create ones that don't however, thus most devices in life
(eg your telephone) have this form or DoS attack.

My sshd also doesn't show this problem and the manual page indicates it
has a 120 second grace timeout for authentication.

The sshd manual page says:

     Gives the grace time for clients to authenticate themselves
             (default 120 seconds).


