Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVAGR4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVAGR4D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVAGRzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:55:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:36291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261379AbVAGRym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:54:42 -0500
Date: Fri, 7 Jan 2005 09:54:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, linux@brodo.de
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
In-Reply-To: <41DEC0BF.4010708@osdl.org>
Message-ID: <Pine.LNX.4.58.0501070949410.2272@ppc970.osdl.org>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org>
 <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
 <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
 <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com>
 <41DEC0BF.4010708@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Randy.Dunlap wrote:
> 
> Brodo, can you add a little more info to this, please?

I think for something like this to be really useful, you should not just
say "can be replaced with Xxxx", but have some docs (or pointers to such)
for both users and developers (depending on who is affected) on _how_ to 
replace it, or fix it.

Also, I'm not convinced about the single-file format. If we want to do
this (I don't know how much it buys, but hey, I certainly also don't have
any objections), I think it would be much nicer to have a separate 
"deprecated" subdirectory, with one file per issue. 

(Not that I think it necessarily needs to be just about deprecated or 
removed features - again, if we do this, I don't see why it shouldn't 
contain the same information about semantic changes, so that when the 
locking for an interface changes, you could have a

	Documentation/changes/vfs-ioctl-locking.txt

that tells what the new rules are).

Would most of the files be small? Sure hope so. But so what?

		Linus
