Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTFDOol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTFDOol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:44:41 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:24023 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263023AbTFDOok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:44:40 -0400
Date: Wed, 4 Jun 2003 15:58:06 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <Pine.LNX.4.44.0306040732470.13753-100000@home.transmeta.com>
Message-ID: <Pine.HPX.4.33L.0306041546190.15504-100000@punch.eng.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003, Linus Torvalds wrote:

> No no no, it's wrong.
>
> If you do something like this, then you also have to teach "select()"
> about this, otherwise you just get busy looping in applications.
>
> In general, we shouldn't do this, unless somebody can show an application
> where it really matters.

I wrote the patch to solve a real-world problem with wall(1), which
occasionally gets stuck writing to somebody's tty. I think it's reasonable
for wall to assume that non-blocking writes are non-blocking.

I'll think about how to do the patch correctly.

Peter

