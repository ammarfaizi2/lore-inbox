Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWJBKva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWJBKva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWJBKva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:51:30 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:29286 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750718AbWJBKv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:51:29 -0400
Date: Mon, 2 Oct 2006 12:51:26 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Junio C Hamano <junkio@cox.net>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Make kernel -dirty naming optional
Message-ID: <20061002105125.GE7523@harddisk-recovery.com>
References: <20060922120210.GA957@slug> <20060922104933.GA3348@harddisk-recovery.com> <20060924090743.GB22731@uranus.ravnborg.org> <20060924101155.GB9271@harddisk-recovery.nl> <7vy7s7y62j.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vy7s7y62j.fsf@assigned-by-dhcp.cox.net>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:44:36PM -0700, Junio C Hamano wrote:
> Erik Mouw <erik@harddisk-recovery.com> writes:
> 
> > make mrproper
> > cp ../config-2.6 .config
> > yes no | make oldconfig
> > fakeroot make targz-pkg
> 
> fakeroot makes the working tree files appear to be owned by
> root.root but does not know git uses the file ownership
> information recorded in the index and uses it to detect if the
> working tree is dirty.  Because the index says they are owned by
> you (the one who pulled from the kernel.org and owns the files
> in the real world not fakeroot world), you get -dirty suffix.

Aha, thanks for the explanation.

> Perhaps "fakeroot -u" would help.

Yes, that helps, I just build linux-2.6.18-gd834c165.tar.gz. Thanks!


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
