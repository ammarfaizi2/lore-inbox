Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVF0Qh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVF0Qh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVF0PBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:01:02 -0400
Received: from nevyn.them.org ([66.93.172.17]:54976 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262049AbVF0OAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:00:37 -0400
Date: Mon, 27 Jun 2005 10:00:29 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       gdb@sources.redhat.com
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050627140029.GB29121@nevyn.them.org>
Mail-Followup-To: Vivek Goyal <vgoyal@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
	gdb@sources.redhat.com
References: <20050624200916.GJ6656@stusta.de> <20050624132826.4cdfb63c.akpm@osdl.org> <20050627132941.GD3764@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627132941.GD3764@in.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 06:59:41PM +0530, Vivek Goyal wrote:
> On Fri, Jun 24, 2005 at 01:28:26PM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@stusta.de> wrote:
> > >
> > > This patch:
> > > - removes the dependency of REGPARM on EXPERIMENTAL
> > > - let REGPARM default to y
> > 
> > hm, a compromise.
> > 
> > One other concern I have with this is that I expect -mregparm will make
> > kgdb (and now crashdump) less useful.  When incoming args are on the stack
> > you have a good chance of being able to see what their value is by walking
> > the stack slots.
> > 
> > When the incoming args are in registers I'd expect that it would be a lot
> > harder (or impossible) to work out their value.
> > 
> > Have the kdump guys thought about (or encountered) this?

GDB is more than capable of handling this - if your compiler is saving
arguments to the stack and dumping out useful information for the
debugger about where it put them.  Recent GCC versions are generally
pretty good about either saving the argument or clearly telling GDB
that it was not saved.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
