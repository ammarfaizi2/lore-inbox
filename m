Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbWBHPQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbWBHPQl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBHPQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:16:41 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:24136 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1161070AbWBHPQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:16:40 -0500
Message-ID: <BAYC1-PASMTP07321AEB36615A344C1581AE000@CEZ.ICE>
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Wed, 8 Feb 2006 10:16:26 -0500
From: sean <seanlkml@sympatico.ca>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still
 don't git git
Message-Id: <20060208101626.3afa69ba.seanlkml@sympatico.ca>
In-Reply-To: <20060208070301.1162e8c3.pj@sgi.com>
References: <20060208070301.1162e8c3.pj@sgi.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.11; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2006 15:18:15.0015 (UTC) FILETIME=[E1CBDF70:01C62CC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 07:03:01 -0800
Paul Jackson <pj@sgi.com> wrote:

> But how in tarnation do I git a checked out copy/clone/whatever of
> Linus's tree that only has the changes up through revision v2.6.16-rc2
> (that doesn't include changes since then)?

Hi Paul,

You create a branch.   This will be a bit easier if you have all of the
tags for each of Linus' releases, do:

$ git fetch --tags

Then you create the branch as at the commit you're interested in:

$ git checkout -b working v2.6.16-rc2

Which tells git to create a branch named "working" as at the commit
referenced by the tag "v2.6.16-rc2".   You can see this worked
by:

$ git branch
  master
  origin
* working

Where the asterisk shows you that you're now operating in the "working"
branch.   And "git log" will show you that the HEAD commit is the
one you're interested in.

HTH,
Sean
