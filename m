Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292522AbSCIHS5>; Sat, 9 Mar 2002 02:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292529AbSCIHRn>; Sat, 9 Mar 2002 02:17:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292533AbSCIHPf>;
	Sat, 9 Mar 2002 02:15:35 -0500
Date: Fri, 8 Mar 2002 19:09:37 -0800
From: Danek Duvall <duvall@emufarm.org>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020309030937.GA244@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org> <20020308222942.A7163@devcon.net> <20020308214148.GA750@lorien.emufarm.org> <20020308233001.B7163@devcon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308233001.B7163@devcon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, after trying all four combinations (call to wmb() moved or not, and
set_user(0, 1) vs set_user(0, 0)), it turns out all four exhibit
skipping, so that's unrelated (in fact, it seems to happen not on net
access, but on redraw -- mozilla's dialogs make xmms skip, too).

The call to set_user() definitely changes the behavior of the directory
in /proc as we expected.

I suppose I'll have to wait for the low latency patch to be updated to
the latest ac kernel; that appears to have been the reason there wasn't
any skipping in my 2.4.18-pre3-ac2.  I tried porting it myself, but the
rejects were significant enough to confuse me, so I'll wait.

I'll leave it for someone else to decide what arguments to set_user()
exec_usermodehelper() should pass.

Thanks all!

Danek
