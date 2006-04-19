Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWDSQd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWDSQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWDSQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:33:28 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:14737 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750950AbWDSQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:33:27 -0400
Date: Wed, 19 Apr 2006 12:33:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Greg KH <greg@kroah.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <20060419154011.GA26635@kroah.com>
Message-ID: <Pine.LNX.4.64.0604191221100.4408@d.namei>
References: <200604072138.35201.edwin@gurde.com>
 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
 <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
 <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <20060419154011.GA26635@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Greg KH wrote:

> So please feel free to submit your patch, especially as without another
> LSM user in the kernel tree, the interface will probably go away.

At this point, LSM has really proven itself to be a bad interface and 
should probably go away in any case.

Its semantics are too weak, and developers are not designing their code 
according to what is suitable for the kernel, but rather, whatever happens 
to fit easily into LSM, which us just about anything.

The LSM interface is also being abused by several proprietary kernel 
modules, some of which are not even security related.  In one case, 
there's code which dangerously revectors SELinux with a shim layer 
designed to try and bypass the GPL.  Some of this is a response to 
unexporting the syscall table, where projects which abused that have now 
switched to LSM.

I think it's clear now, if it wasn't already, that bad interfaces foster 
bad code.


- James
-- 
James Morris
<jmorris@namei.org>
