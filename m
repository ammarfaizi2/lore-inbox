Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWEBEWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWEBEWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 00:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWEBEWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 00:22:50 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:53739 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932366AbWEBEWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 00:22:49 -0400
Date: Tue, 2 May 2006 00:22:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/4] MultiAdmin LSM
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0605012354160.3320@d.namei>
References: <20060417162345.GA9609@infradead.org>
 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This module implements two distinct ideas:

(1) Multiple superusers with distinct UIDs.

More than one root on a system I think is generally regarded as a bad 
idea.  I'm not sure why you'd use a scheme like this instead of, say, sudo 
or custom setuid helpers for specific tasks -- whatever the case, I think 
such issues can be addressed entirely in userspace.


(2) Partially decomposing the superuser and protecting some users from 
    some decomposed superusers, and decomposing CAP_SYS_ADMIN.

This is a special-case security policy hard-coded into the kernel.  It 
lacks a clear design rationale, and does not seem amenable to analysis, as 
its access control coverage is incomplete.

As already suggested, it may be worth looking at just decomposing 
CAP_SYS_ADMIN, although it's not clear how do to this correctly for the 
general case.


- James
-- 
James Morris
<jmorris@namei.org>
