Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751900AbWIXKL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbWIXKL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 06:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWIXKL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 06:11:58 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:55716 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751900AbWIXKL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 06:11:57 -0400
Date: Sun, 24 Sep 2006 12:11:55 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Make kernel -dirty naming optional
Message-ID: <20060924101155.GB9271@harddisk-recovery.nl>
References: <20060922120210.GA957@slug> <20060922104933.GA3348@harddisk-recovery.com> <20060924090743.GB22731@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924090743.GB22731@uranus.ravnborg.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 11:07:43AM +0200, Sam Ravnborg wrote:
> On Fri, Sep 22, 2006 at 12:49:34PM +0200, Erik Mouw wrote:
> > FWIW, if I enable git name tagging, every kernel I compile is tagged as
> > "dirty", even if I cloned it directly from kernel.org and didn't make
> > any change to the source. That makes the "dirty" tag useless IMHO.
> 
> make mrproper
> make allmodconfig
> make prepare
> make kernelrelease 
> 	2.6.18-ga5fa393b
> vi MAINTAINERS
> make prepare
> make kernelrelease
> 	2.6.18-ga5fa393b-dirty
> 
> So it wrks for me.
> Can you provice a few more details what steps you do when you see it failing.

make mrproper
cp ../config-2.6 .config
yes no | make oldconfig
fakeroot make targz-pkg
...
Tarball successfully created in /home/erik/git/linux-2.6/linux-2.6.18-g4f5537de-dirty.tar.gz

(I use fakeroot in order to make sure that all files in the tarball are
root.root. Otherwise I would have to chown /lib/modules or modprobe
would complain.)


Erik

PS: I'm on holiday for a week, so don't expect an immediate reply.

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
