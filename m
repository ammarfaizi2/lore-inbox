Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbTKSNb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTKSNb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:31:28 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:18427 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S264020AbTKSNb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:31:27 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Jamie Lokier <jamie@shareable.org>, Andi Kleen <ak@suse.de>
Subject: Re: OT: why no file copy() libc/syscall ??
Date: Wed, 19 Nov 2003 07:30:36 -0600
X-Mailer: KMail [version 1.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <1068512710.722.161.camel@cube.suse.lists.linux.kernel> <p734qx7rmyf.fsf@oldwotan.suse.de> <20031118154921.GA28942@mail.shareable.org>
In-Reply-To: <20031118154921.GA28942@mail.shareable.org>
MIME-Version: 1.0
Message-Id: <03111907303600.25311@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 November 2003 09:49, Jamie Lokier wrote:
> Andi Kleen wrote:
> > > s/EINTR/short count/, of course :)
> >
> > That would be buggy because existing users of sendfile don't know
> > about this and would silently only copy part of the file when a signal
> > happens.
>
> That doesn't make sense.  There aren't any existing users of sendfile
> to copy files.

True. It also doesn't address the issue of what to do when the file copy is
being done on a remote server and not by something local. Synchronizing
a remote interrupt could really be nasty.
