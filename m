Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWIKOCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWIKOCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWIKOCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:02:52 -0400
Received: from MAIL.13thfloor.at ([213.145.232.33]:52655 "EHLO
	MAIL.13thfloor.at") by vger.kernel.org with ESMTP id S1750972AbWIKOCv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:02:51 -0400
Date: Mon, 11 Sep 2006 16:02:50 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Containers <containers@lists.osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] usb: Fixup usb so it uses struct pid
Message-ID: <20060911140250.GA27223@MAIL.13thfloor.at>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Containers <containers@lists.osdl.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <m1hczgfi3h.fsf@ebiederm.dsl.xmission.com> <20060910111249.c2e9c5f2.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910111249.c2e9c5f2.zaitcev@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 11:12:49AM -0700, Pete Zaitcev wrote:
> On Sat, 09 Sep 2006 22:42:10 -0600, ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > The problem by remember a user space process by it's pid it is
> > possible that the process will exit, pid wrap around will occur and a
> > different process will appear in it's place.
> 
> ... which is completely all right in this case. We used to have an
> implementation which tried to hold onto the task_struct and that sucked.
> It is only possible for the task to disappear without notifying devio
> under very special conditions only, which involve forking with parent
> exiting. In other words, even a buggy application won't trigger this
> without deliberately trying. And when it happens, uid checks make sure
> that other users are not affected.
> 
> >  Holding a reference
> > to a struct pid avoid that problem, and paves the way
> > for implementing a pid namespace.
> 
> That may be useful.
> 
> The patch itself seems straightforward if we can trust your struct
> pid thingies. If OpenVZ people approve, I don't mind.

perfectly fine from my side

best,
Herbert

> -- Pete
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers
