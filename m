Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWCNQlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWCNQlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCNQlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:41:46 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23755
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751355AbWCNQlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:41:45 -0500
From: Rob Landley <rob@landley.net>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: How do I get the ext3 driver to shut up?
Date: Tue, 14 Mar 2006 11:41:53 -0500
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603132218.39511.rob@landley.net> <20060313231407.7606f0d3.akpm@osdl.org> <20060314144849.GC16264@thunk.org>
In-Reply-To: <20060314144849.GC16264@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141141.53230.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 9:48 am, Theodore Ts'o wrote:
> On Mon, Mar 13, 2006 at 11:14:07PM -0800, Andrew Morton wrote:
> > >  Guess which device driver feels a bit chatty?
> > >
> > > ...
> > >
> > >  VFS: Can't find ext3 filesystem on dev loop0.
> >
> > That's only printed if the sys_mount() caller set MS_VERBOSE in `flags'.
>
> I should have been a bit more explict in my previous message.
> Actually, if you trace down the logic, it's only printed if
> sys_mount() __DIDN'T__ set MS_VERBOSE in 'flags'.  The code in
> fs/super.c sets the "silent" flag if (flags & MS_VERBOSE) is non-zero.
> The meaning is reversed, which is counterintuitive.  Hence, my patch.

Just confirming: you aren't proposing a change to kernel behavior, instead the 
the busybox mount program should set MS_VERBOSE/MS_SILENT by default if it 
wants to avoid these messages appearing on the console?

Rob
-- 
Never bet against the cheap plastic solution.
