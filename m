Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUDEMjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUDEMjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:39:39 -0400
Received: from mail.shareable.org ([81.29.64.88]:57751 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262170AbUDEMji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:39:38 -0400
Date: Mon, 5 Apr 2004 13:39:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Pavel Machek <pavel@ucw.cz>, mj@ucw.cz, jack@ucw.cz,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405123933.GC19842@mail.shareable.org>
References: <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <m1n05soqh2.fsf@ebiederm.dsl.xmission.com> <20040403194344.GA5477@mail.shareable.org> <20040405083549.GD28924@wohnheim.fh-wedel.de> <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> As scheme that does not isolate the invalidate to the new copy worries me.

It is possible to isolate the invalidate to mappings of the newly
broken cowlink only.

There is still the problem of MAP_LOCKED, or more realistically
mlockall() used with mappings of glibc etc. on a filesystem snapshot
made using cowlinks.  The easiest thing is obviously to break the
cowlink when a mapping is locked, but it's not nice.

-- Jamie
