Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUHZA6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUHZA6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUHZA6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:58:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:23443 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266603AbUHZA40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:56:26 -0400
Date: Wed, 25 Aug 2004 17:56:08 -0700
From: Chris Wright <chrisw@osdl.org>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Tim Hockin <thockin@hockin.org>,
       LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Message-ID: <20040825175608.Y1973@build.pdx.osdl.net>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <412D2BD2.2090408@sun.com>; from Michael.Waychison@Sun.COM on Wed, Aug 25, 2004 at 08:16:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Waychison (Michael.Waychison@Sun.COM) wrote:
> This provides minimal protection if any: the user may remount any block
> devices on any given tree in his 'namespace' (in the sense of "that is
> what we call a mount-table in Linux").  *

Namespaces aren't currently expressive enough, and have caveats like
these, and can't express detailed access controls.

> If I understand what Hans is looking to get done, he's asking for
> someone to architect a system where any given process can be restricted
> to seeing/accessing a subset of the namespace (in the sense of "a tree
> of directories/files").  Eg: process Foo is allowed access to write to
> /etc/group, but _not_ allowed access to /etc/shadow, under any
> circumstances && Foo will be run as root.  Hell, maybe Foo is never able
> to even _see_ /etc/shadow (making it a true shadow file :).

This has already been done.  LSM provides the infrastructure, things
like LIDS and SubDomain do this fairly directly.  SELinux does this as
well using types as an intermediary.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
