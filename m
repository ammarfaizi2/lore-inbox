Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWAHTad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWAHTad (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWAHTad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:30:33 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:3253 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1161103AbWAHTab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:30:31 -0500
Date: Sun, 8 Jan 2006 14:30:00 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, David Lang <dlang@digitalinsight.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060108193000.GB10232@filer.fsl.cs.sunysb.edu>
References: <E1EuPZg-0008Kw-00@calista.inka.de> <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr> <Pine.LNX.4.62.0601051726290.973@qynat.qvtvafvgr.pbz> <20060106053609.GB32105@redhat.com> <20060108132132.GA1952@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060108132132.GA1952@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 02:21:32PM +0100, Pavel Machek wrote:
> On Pá 06-01-06 00:36:09, Dave Jones wrote:
> > On Thu, Jan 05, 2006 at 05:28:59PM -0800, David Lang wrote:
> >  > On Thu, 5 Jan 2006, Jan Engelhardt wrote:
> >  > 
> >  > >Also note that the kernel generates a lot of noise^W text - if now the
> >  > >start scripts from $YOUR_FAVORITE_DISTRO also fill up, I can barely reach
> >  > >the top of the kernel when it says
> >  > > Linux version 2.6.15 (jengelh@gwdg-wb04.gwdg.de) (gcc version 4.0.2
> >  > > 20050901 (prerelease) (SUSE Linux)) #1 Tue Jan 3 09:21:27 CET 2006
> >  > 
> >  > enable a few different types of encryption and you have to enlarge the 
> >  > buffer (by quite a bit). the fact that all the encryption tests print 
> >  > several lines each out and can't be turned off (short of a quiet boot 
> >  > where you loose everything) is one of the more annoying things to me right 
> >  > now.
> >  > 
> >  > this large boot message issue also slows your boot significantly if you 
> >  > have a fast box that has a serial console, it takes a long time to dump 
> >  > all that info out the serial port.
> > 
> > So disable CONFIG_CRYPTO_TEST. There's no reason to test this stuff every boot.
> 
> Maybe even with CRYPTO_TEST enabled we could only report _failures_?

Why? As far as I know, it is intended for developers as a regression test. I say
if you don't like the output, make the thing a module or don't compile it at all.

Jeff.
