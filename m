Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTFYPCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264509AbTFYPCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:02:20 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:64261 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264503AbTFYPCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:02:19 -0400
Date: Wed, 25 Jun 2003 16:16:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve Lord <lord@sgi.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, grendel@debian.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625161627.A20049@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve Lord <lord@sgi.com>, Arjan van de Ven <arjanv@redhat.com>,
	grendel@debian.org, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com> <20030625134129.GG1745@thanes.org> <1056551143.5779.0.camel@laptop.fenrus.com> <20030625153545.A16074@infradead.org> <1056553902.1416.61.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056553902.1416.61.camel@laptop.americas.sgi.com>; from lord@sgi.com on Wed, Jun 25, 2003 at 10:11:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 10:11:40AM -0500, Steve Lord wrote:
> This is all backwards compatibility with folks expecting Irix behavior,
> and I think on Irix it is even a backwards compatibility thing. If we
> were not having a major power outage at work right now I could look
> at Irix and confirm this. Imposing different semantics on the rest of
> the filesystems did not seem like the right thing to do.

Actually there's a posix option group for finding out exactly that,
(see http://people.redhat.com/drepper/posix-option-groups.html#CHOWN_RESTRICTED)
but yeah it might be more of a legacy thing.

Adding a common sysctl for this would allow glibc to properly implement
patchconf(..., _PC_CHOWN_RESTRICTED), but it seems SuSv2/3 sais it must
be always defined:

http://www.opengroup.org/onlinepubs/007908799/xsh/chown.html
