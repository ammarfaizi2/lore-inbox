Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTENMjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTENMjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:39:12 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:28361 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261960AbTENMjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:39:11 -0400
Subject: Re: odd db4 error with 2.5.69-mm4 [was Re: Huraaa for 2.5]
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Shawn <core@enodev.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1052877161.3569.17.camel@www.enodev.com>
References: <1052866461.23191.4.camel@www.enodev.com>
	 <20030514012731.GF8978@holomorphy.com>
	 <1052877161.3569.17.camel@www.enodev.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052916589.1912.8.camel@iso-8590-lnx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 08:49:49 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.8, required 10,
	AWL, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As root, I basically can't use rpm at all. I think it's select() related
> as strace shows it timing out. The odd thing is that it works great as a
> non-privileged user.
> 
> 2.5.69-mm4, otherwise mostly stock rh90 setup.
> 
> [root@www root]# rpm -qi iptables
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily
> unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> package iptables is not installed
> [root@www root]#

This is a long known problem, you can work around it with
LD_ASSUME_KERNEL=2.4.19 or get the 4.2-1 rpms from
ftp://ftp.rpm.org/pub/rpm/test-4.2/.

Basically follow the steps in Redhat Bugzilla
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=89662 and you
should be all set.

Later,
Tom


