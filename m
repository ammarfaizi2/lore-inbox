Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTKJTYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbTKJTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:24:44 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:28047 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264075AbTKJTYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:24:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 11:23:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FAFE22B.3030108@zytor.com>
Message-ID: <Pine.LNX.4.44.0311101122420.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, H. Peter Anvin wrote:

> Andrea Arcangeli wrote:
> > 
> > you must pick file2 before file1:
> > 
> > 	you:
> > 
> > 	do
> > 		get file2
> > 		get repo-file1-j
> > 		get file1
> > 	while file2 != file1 && sleep 10
> >
> 
> Okay... I'm starting to think the sequencing requirements on these files
> may be hard to maintain across multiple levels of rsync... but perhaps
> I'm wrong, in particular if 'file2' sorts hierachially-lexically last
> and 'file1' first...

Doing something like:

rsync file2
rsync repo
rsync file1

should work, doesn't it?



- Davide


