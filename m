Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWGKTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWGKTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWGKTz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:55:58 -0400
Received: from [212.33.164.213] ([212.33.164.213]:57874 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932114AbWGKTz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:55:57 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VFS: FS CoW using redirection
Date: Tue, 11 Jul 2006 22:57:08 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607082041.54489.a1426z@gawab.com> <a4e6962a0607081132u4558473cgf89b8b25fcea317d@mail.gmail.com> <200607091550.36407.a1426z@gawab.com>
In-Reply-To: <200607091550.36407.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607112257.08071.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Eric Van Hensbergen wrote:
> > On 7/8/06, Al Boldi <a1426z@gawab.com> wrote:
> > > Copy on Write is a neat way to quickly achieve a semi-clustered
> > > system, by mounting any shared FS read-only and redirecting writes to
> > > some perClient FS.
> > >
> > > Would this redirection be easy to implement into the VFS?
> >
> > There are a variety of solutions that have been proposed or are
> > available to do this sort of thing.  You may want to start by looking
> > at unionfs and mapfs.  There are also folks looking at doing this from
> > the block layer (look at the dm-userspace + cowd as well as evms and
> > lvm snapshots).
>
> The idea here, is to do things completely transparent while being as
> unintrusive as possible, by relying on the current FS infrastructure, w/o
> introducing another VFS.
>
> Consider something simple like this:
>
> VFS - anyFS1 (r/w) used normally, unless ENotFound, then redirect read to
>     \              anyFS2, or CoW from anyFS2 to anyFS1.
>       anyFS2 (r/o) used normally.
>
> i.e: Does the VFS provide hooks for perMount Handlers?

Silence is probably an indication that the VFS does not provide hooks.

The question then:

1. Would it be difficult to introduce perMount Handler hooks into the VFS?

2. Would it be easier to replace the current VFS with one that offers a more 
flexible/open configuration?

3. Would these changes be welcome, or is the VFS considered to be a forbidden 
zone?


Thanks!

--
Al

