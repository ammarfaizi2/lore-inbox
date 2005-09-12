Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVILQu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVILQu7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVILQu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:50:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9112 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751030AbVILQu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:50:58 -0400
Date: Mon, 12 Sep 2005 17:50:56 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: new asm-offsets.h patch problems
Message-ID: <20050912165056.GM25261@ZenIV.linux.org.uk>
References: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F045A9188@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:00:06AM -0700, Luck, Tony wrote:
> So I still don't understand what is really happening here.
> 
> I left my build script running overnight ... working on a
> kernel at the 357d596bd... commit (where Linus merged in
> my tree last night).  This one has your "archprepare" patch
> already included.
> 
> Sometimes a build for a config succeeds, and sometimes it
> fails. (tiger_defconfig for the last six builds has had a
> GOOD, BAD, BAD, BAD, GOOD, GOOD sequence, while bigsur_defconfig
> went GOOD, BAD, BAD, BAD, BAD, BAD).  This non-determinism
> doesn't fit in well with your explanation of missing defines
> for PAGE_SIZE etc.

There's more, apparently - I'm seeing
make # successful full build
make C=2 # triggering full rebuild, not just sparse run
