Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUC2MnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUC2MmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:42:07 -0500
Received: from mail.shareable.org ([81.29.64.88]:21139 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262909AbUC2Mkc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:40:32 -0500
Date: Mon, 29 Mar 2004 13:40:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040329124015.GB4984@mail.shareable.org>
References: <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com> <20040325174942.GC11236@mail.shareable.org> <m1ekrgyf5y.fsf@ebiederm.dsl.xmission.com> <20040325194303.GE11236@mail.shareable.org> <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com> <20040327102828.GA21884@mail.shareable.org> <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com> <20040327214238.GA23893@mail.shareable.org> <20040329092835.GD1453@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329092835.GD1453@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Actually, there's 4th strategy, too. You could implement sharing at block level.
> Block free bitmap would become bigger, but you could do some tricks to keep it
> at ~8 bits per block...

For sharing source trees and such, and even for COW overlays of
/usr/lib and /usr/bin, that would have no benefit: you never write to
just part of a source or object file.

For databases (including things like the RPM database), and snapshots
of filesystems, it would be more useful.

-- Jamie
