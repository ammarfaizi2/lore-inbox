Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWIXWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWIXWsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWIXWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:48:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58824 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932112AbWIXWsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:48:52 -0400
Date: Sun, 24 Sep 2006 23:48:51 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Andrey Mirkin <amirkin@sw.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 18/28] kbuild: fail kernel compilation in case of unresolved module symbols
Message-ID: <20060924224851.GB29920@ftp.linux.org.uk>
References: <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <20060924222026.GS29920@ftp.linux.org.uk> <20060924223534.GA27984@uranus.ravnborg.org> <20060924223643.GT29920@ftp.linux.org.uk> <20060924224740.GB28051@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924224740.GB28051@uranus.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 12:47:40AM +0200, Sam Ravnborg wrote:
> > That's out of 25 targets.  The only variants that do _NOT_ trigger are
> > amd64, amd64-UP, i386 and uml-amd64.
> 
> How many of these ougth to be fixed then?

In theory - all of them.  Right now that's just plain not feasible...

> > I more or less agree with rationale behind making that default, but I'd
> > very much appreciate a way to override that.  For now I've just made the
> > -w line unconditional, but the fewer infrastructure patches I've to carry...
> OK. Will include it in next round of kbuild updates.

BTW, an alternative would be to stop unconditionally after full set of checks
and not bother with .mod.o/.ko at all.  _Not_ as a default, of course...
