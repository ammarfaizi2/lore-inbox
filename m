Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVFPV2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVFPV2P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVFPV2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:28:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:47765 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261848AbVFPV2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:28:06 -0400
Date: Thu, 16 Jun 2005 23:27:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hans Reiser <reiser@namesys.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
       Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
Message-ID: <20050616212728.GA1979@elf.ucw.cz>
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org> <42B091E3.3010908@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B091E3.3010908@namesys.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Kenichi-San,
> >
> >Part of the problem is that we are limited by the constraints of the
> >POSIX specification for error handling. 
> >
> Ted, if I understand you correctly, I agree with you.  ;-)
> 
> What users need is for a window to pop up saying "the usb drive is
> turned off" or "we are getting checksum errors from XXX, this may
> indicate hardware problems that require your attention".
> 
> Now that GUIs exist, and now that more errors are possible because the
> kernel is more complex, perhaps kernel error handling should be
> reconsidered.  I don't have the feeling that anyone has felt themselves
> authorized to take a deep look at how this ought to be designed.  I mean
> sure, there are sometimes console windows that things get printed into,
> but unsophisticated users basically want to be prompted if something

I believe syslog can handle this just fine. Just add some gui code to
watch syslog, and if high-enough (KERN_CRIT?) message happens, display
that message to user.

...which brings interesting question of "how to internationalize this
beast", but list of KERN_CRIT messages should be reasonably small.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
