Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264187AbTIIQCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTIIQCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:02:39 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:39612 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264187AbTIIQCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:02:37 -0400
Subject: Re: Make Menuconfig and Make Xconfig errors in Mandrake 9.2 rc1
From: Steven Cole <elenstev@mesatop.com>
To: Anton Kholodenin <cicprogr@mail.dux.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1063115985.1664.14.camel@spc9.esa.lanl.gov>
References: <000701c376ba$11e87ef0$370101c8@antontest>
	 <1063115985.1664.14.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1063123083.1663.34.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 09 Sep 2003 09:58:03 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 07:59, Steven Cole wrote:
> On Tue, 2003-09-09 at 04:06, Anton Kholodenin wrote:
> > I find 2 errors in Mandrake 9.2 rc 1
> > 
> As others noted, a Mandrake-specific list is a better choice in this
> instance, but the problem you noted below happens occasionally in 2.4
> bleeding edge stuff, so I'm posting something for you to look for.
> > 
> > 2. If i do cd /usr/src/linux; make xconfig program not started and write to
> > console:
> 
>3rdparty/lufs/Config.in: 2: can't handle
dep_bool/dep_mbool/dep_tristate

Replying to myself, apologies to all for the previous noise.
I hadn't looked at the error closely enough.  My previous post was not
apropos to Anton's specific problem.

Try doing this from /usr/src/linux:
grep dep_ 3rdparty/lufs/Config.in

You'll see various lines with something like:
dep_tristate ' Some prompt' CONFIG_SOMETHING $CONFIG_SOMETHINGELSE

The $CONFIG_SOMETHINGELSE may be missing on some line.  You can kludge
it by changing the dep_tristate to a plain tristate.

The Mandrake 9.2 rc2 is out now, so you might want to look at that
instead.

Steven



