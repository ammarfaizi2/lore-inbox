Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbWBIQH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWBIQH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWBIQH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:07:56 -0500
Received: from mail.fieldses.org ([66.93.2.214]:9117 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S932554AbWBIQHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:07:55 -0500
Date: Thu, 9 Feb 2006 11:07:47 -0500
To: Diego Calleja <diegocg@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, jes@sgi.com, pj@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: git for dummies, anyone?
Message-ID: <20060209160746.GA953@fieldses.org>
References: <20060208070301.1162e8c3.pj@sgi.com> <yq0vevollx4.fsf@jaguar.mkp.net> <43EB4F05.8090400@pobox.com> <20060209163546.493334f8.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209163546.493334f8.diegocg@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 04:35:46PM +0100, Diego Calleja wrote:
> - Update your copy:
>   cd linux-2.6; git pull; git pull --tags

Note just the one "git pull" seems to fetch tags on its own now without
need for the last step.

> - How to go back to a certain snapshot
>   git reset --hard v2.6.13 (ls .git/refs/tags to see all the tags). Not the
>   cleanest method, I think.

If you intend to do apply patches against that particular version, you
could also create a new branch:

	git checkout -b my-v2.6.13-branch v2.6.13

or if you know from the start that you only want to update up to a
certain version,

	git pull tag v2.6.13

instead of just "git pull".

I did some work on a new tutorial under Documentation/tutorial.txt in
the git source tree:

http://www.kernel.org/pub/software/scm/git/docs/tutorial.html

which might be helpful, though it isn't so specifically targetted at the
case of linux testers.  It wouldn't be hard to write something like
that, though.  Git should make that kind of use pretty easy.

--b.
