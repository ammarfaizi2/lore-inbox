Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWECXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWECXNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWECXNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:13:34 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:17349 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751388AbWECXNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:13:33 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: Re: [WARNING] please stop using git.git "next" for now
References: <7virombwro.fsf@assigned-by-dhcp.cox.net>
cc: linux-kernel@vger.kernel.org
Date: Wed, 03 May 2006 16:13:32 -0700
In-Reply-To: <7virombwro.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 03 May 2006 14:53:31 -0700")
Message-ID: <7vejzabt2b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I just noticed there is a breakage in write-tree optimization
> that uses the new cache-tree data structure in the "next"
> branch.  Switching branches with "git checkout anotherbranch"
> when your index exactly matches the current HEAD commit and then
> immediately doing write-tree produces a nonsense tree, and
> commits on top of that results in tree objects that have
> duplicated entries.
>
> I will be working on a fix now, but in the meantime please do
> not use the "next" branch for real work.  Sorry for the
> breakage.

Two-way merge by read-tree forgot to invalidate the directories
a new element was added underneath.  The fix is simple and will
be in the "next" I'll push out tonight.

Sorry for the noise.


