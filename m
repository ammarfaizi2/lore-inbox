Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUHQUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUHQUtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUHQUtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:49:55 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:21904 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266705AbUHQUtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:49:53 -0400
Date: Wed, 18 Aug 2004 00:50:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] fix warnings in scripts/binoffset.c
Message-ID: <20040817225001.GA24203@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040816202805.356f134d.rddunlap@osdl.org> <20040817221332.GB23582@mars.ravnborg.org> <20040817132104.5f2dc7d8.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817132104.5f2dc7d8.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 01:21:04PM -0700, Randy.Dunlap wrote:
> | 
> | Added to my tree - but..
> | How am I supposed to build binoffset when I decide
> | to use extract-config?
> 
> Good question.  I'm (slowly) working on that.  I also have
> some contributed patches that address that... patience.
> 
> I was thinking about 'make getconfig', but that would be only
> one way to use it.  It would still need an external/out-of-tree
> solution also.  ('make getconfig' would build binoffset and run
> the extract-ikconfig script.)

If you want to do that you need to move binoffset to scripts/kconfig/
All *config target are handled by the Makefile there.
And if you want to compile a hostprogram only on demand it needs to
be in the same dir as the Makefile.  It can be worked around, but
moving the file is the better solution.
One other way would be to build binoffset when CONFIG_IKCONFIG is set.

	Sam
