Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUEEDWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUEEDWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 23:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUEEDWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 23:22:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:27049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbUEEDWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 23:22:38 -0400
Date: Tue, 4 May 2004 20:21:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Message-Id: <20040504202106.106529b3.rddunlap@osdl.org>
In-Reply-To: <s5gy8o7bnhv.fsf@patl=users.sf.net>
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>
	<408D65A7.7060207@nortelnetworks.com>
	<s5gisfm34kq.fsf@patl=users.sf.net>
	<c6od9g$53k$1@gatekeeper.tmr.com>
	<s5ghdv0i8w4.fsf@patl=users.sf.net>
	<20040504200147.GA26579@kroah.com>
	<s5ghduvdg1u.fsf@patl=users.sf.net>
	<20040504223550.GA32155@kroah.com>
	<s5gy8o7bnhv.fsf@patl=users.sf.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 May 2004 22:49:56 -0400 "Patrick J. LoPresti" <patl@users.sourceforge.net> wrote:

| Greg KH <greg@kroah.com> writes:
| 
| > On Tue, May 04, 2004 at 05:56:48PM -0400, Patrick J. LoPresti wrote:
| >
| > > But what if it fails to bind?  For example, what if an error occurs?
| > > Or what if the keyboard is on the module's blacklist?  How do I know
| > > when to stop waiting?
| > 
| > You do not, sorry.
| 
| That is disappointing.  I mean, I deal with Microsoft products a lot,
| where "unreliable by design" is normal.  But I expected better from
| Linux.

It's just a different model than what you are looking for.

The hid (or whatever) driver supports a hotplug environment.
It cannot know what device(s) are expected to be present
or just which ones you are looking for.

If it's a huge problem, you have the source code, modify the
driver to do what you want it to do.

| > > Ideally, what I would like is for "modprobe <driver>" to wait
| > > until all hardware handled by that driver is either ready for use
| > > or is never going to be.  That seems simple and natural to me.
| > 
| > Sorry, but this is not going to happen.  It does not fit into the
| > way the kernel handles drivers anymore.  Again, sorry.
| 
| OK, an arbitrary flaky delay it is.  Thanks!


--
~Randy
