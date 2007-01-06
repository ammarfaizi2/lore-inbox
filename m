Return-Path: <linux-kernel-owner+w=401wt.eu-S932148AbXAFUNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbXAFUNo (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbXAFUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:13:44 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38543 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148AbXAFUNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:13:43 -0500
Date: Sat, 6 Jan 2007 12:13:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nicholas Miell <nmiell@comcast.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       "J.H." <warthog9@kernel.org>, Willy Tarreau <w@1wt.eu>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20070106121301.d07de0c9.akpm@osdl.org>
In-Reply-To: <1168112266.2821.2.camel@entropy>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<20061219063413.GI24090@1wt.eu>
	<1166511171.26330.120.camel@localhost.localdomain>
	<20070106103331.48150aed.randy.dunlap@oracle.com>
	<459FF60D.7080901@zytor.com>
	<1168112266.2821.2.camel@entropy>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 11:37:46 -0800
Nicholas Miell <nmiell@comcast.net> wrote:

> On Sat, 2007-01-06 at 11:18 -0800, H. Peter Anvin wrote:
> > Randy Dunlap wrote:
> > >
> > >>> BTW, yesterday my 2.4 patches were not published, but I noticed that
> > >>> they were not even signed not bziped on hera. At first I simply thought
> > >>> it was related, but right now I have a doubt. Maybe the automatic script
> > >>> has been temporarily been disabled on hera too ?
> > >> The script that deals with the uploads also deals with the packaging -
> > >> so yes the problem is related.
> > > 
> > > and with the finger_banner and version info on www.kernel.org page?
> > 
> > Yes, they're all connected.
> > 
> > The load on *both* machines were up above the 300s yesterday, probably 
> > due to the release of a new Knoppix DVD.
> > 
> > The most fundamental problem seems to be that I can't tell currnt Linux 
> > kernels that the dcache/icache is precious, and that it's way too eager 
> > to dump dcache and icache in favour of data blocks.  If I could do that, 
> > this problem would be much, much smaller.

Usually people complain about the exact opposite of this.

> Isn't setting the vm.vfs_cache_pressure sysctl below 100 supposed to do
> this?

yup.
