Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312400AbSDEImE>; Fri, 5 Apr 2002 03:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312396AbSDEIlz>; Fri, 5 Apr 2002 03:41:55 -0500
Received: from ns.suse.de ([213.95.15.193]:5135 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312400AbSDEIln>;
	Fri, 5 Apr 2002 03:41:43 -0500
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CACEF18.CE742314@zip.com.au.suse.lists.linux.kernel> <Pine.LNX.4.33.0204042330270.10358-100000@twinlark.arctic.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Apr 2002 10:41:39 +0200
Message-ID: <p73pu1esfjw.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet <dean-list-linux-kernel@arctic.org> writes:
> 
> in some ways, the filesystem is the wrong place to do this type of
> activity -- you could approach the problem as a block layer device between
> the fs and the hardware which maintains statistics on access patterns and
> moves blocks around to optimise access time -- which lets you fix all
> sorts of seeking problems.  i guess the challenge would be maintaining a
> map of logical block number to physical block number.  hmm.  guess that's
> kind of hard.

LVM does this already (including the statistics). I guess you could write
a pass to reorganize PEs and make sure that a bootup time the PEs 
are always read completely even when they contain multiple files.

-Andi
