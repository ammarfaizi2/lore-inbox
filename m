Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWDGHw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWDGHw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 03:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWDGHw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 03:52:27 -0400
Received: from mail.suse.de ([195.135.220.2]:3232 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932328AbWDGHw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 03:52:26 -0400
From: Neil Brown <neilb@suse.de>
To: "Tony Luck" <tony.luck@gmail.com>
Date: Fri, 7 Apr 2006 17:52:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17462.6689.821815.412458@cse.unsw.edu.au>
Cc: "Mike Hearn" <mike@plan99.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add a /proc/self/exedir link
In-Reply-To: message from Tony Luck on Thursday April 6
References: <4431A93A.2010702@plan99.net>
	<m1fykr3ggb.fsf@ebiederm.dsl.xmission.com>
	<44343C25.2000306@plan99.net>
	<12c511ca0604061633p2fb1796axd5acad8373532834@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday April 6, tony.luck@gmail.com wrote:
> > > I have concerns about security policy ...
> >
> > I'm not sure I understand. Only if you run that program, and if you
> > don't have access to the intermediate directory, how do you run it?
> 
> It leaks information about the parts of the pathname below the
> directory that you otherwise would not be able to see.  E.g. if
> I have $HOME/top-secret-projects/secret-code-name1/binary
> where the top-secret-projects directory isn't readable by you,
> then you may find out secret-code-name1 by reading the
> /proc/{pid}/exedir symlink.

But we already have /proc/{pid}/exe which is a symlink to the
executable, thus exposing all the directory names already.

NeilBrown
