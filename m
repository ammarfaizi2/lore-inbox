Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUCYTnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUCYTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:43:14 -0500
Received: from mail.shareable.org ([81.29.64.88]:29073 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263584AbUCYTnI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:43:08 -0500
Date: Thu, 25 Mar 2004 19:43:03 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040325194303.GE11236@mail.shareable.org>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> One of the rougher patches, in that we don't have persistent inode
> numbers.  Basically the two files never have the same inode number.
> To the user they are always presented as two separate files.

That is not useful for me or the other people who want to use this to
duplicate large source trees and run "diff" between trees.

"diff" depends on being able to check if files in the two trees are
identical -- by checking whether the inode number and device (and
maybe other stat data) are identical.  This allows "diff -ur" between
two cloned trees the size of linux to be quite fast.  Without that
optimisation, it's very slow indeed.

-- Jamie
