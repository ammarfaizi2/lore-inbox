Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269154AbUIHVUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269154AbUIHVUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUIHVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:20:43 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:21844 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269154AbUIHVUj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:20:39 -0400
Date: Thu, 9 Sep 2004 01:20:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [scripts] pass %{_smp_mflags} to make(1) in scripts/package/mkspec
Message-ID: <20040908232058.GB10514@mars.ravnborg.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
References: <544180000.1094575502@[10.10.2.4]> <20040907141741.58174cfd.akpm@osdl.org> <20040907215846.GR3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907215846.GR3106@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:58:46PM -0700, William Lee Irwin III wrote:
> On Tue, Sep 07, 2004 at 02:17:41PM -0700, Andrew Morton wrote:
> > Yes, I get them too, with make -j6(ish).  I used to get tons of these
> > warnings, but it stopped happening maybe a year ago.  It looks like Sam
> > found a way to bring it back ;)
> 
> This appears to have a specific effect, which is that make -j$N rpm in
> fact runs single-threaded. I've been using the following patch on SuSE
> and RedHat systems for a while.
> 
> This patch passes %{_smp_mflags} to various build phases in
> scripts/package/mkspec so that -j$N is honored by make rpm.

Finally applied this.
I still plan to look into this pkg stuff - but this may be the best
way for the rpm-pkg target.

	Sam
