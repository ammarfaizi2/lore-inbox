Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTDJWDb (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTDJWDb (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:03:31 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:12177 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S264208AbTDJWDa (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 18:03:30 -0400
Subject: Re: Possible bug in ip_conntrack on ip change
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Mario TRENTINI <mario.trentini@polytechnique.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030410201816.GA10975@wodar.local.gxaafoot.homelinux.org>
References: <20030410201816.GA10975@wodar.local.gxaafoot.homelinux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050012907.11156.43.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Apr 2003 00:15:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 22:18, Mario TRENTINI wrote:
> Dear list,
> 
> I've recently reboot my linux router due to fool ip_conntrack table
> (/proc/net/ip_conntrack). The box is hook up to the internet with
> dynamically assign ip and run a 2.4.20 kernel.
> Upon investigation after the reboot, it appears that the table contains
> stale entries of connections made with previous ip addresses that slowly
> fill it up.

Did you apply the pending/submitted patches from patch-o-matic?
There's a known bug in conntrack in kernel 2.4.20 that can make old
connections still hang around. It's fixed in the latest 2.4.21-pre
kernel.

Or you can download patch-o-matic and patch your 2.4.20 kernel.
(ftp://ftp.netfilter.org/pub/patch-o-matic/snapshot/patch-o-matic-20030410.tar.bz2)
And then execute ./runme --batch pending

And there's an entry about this problem with MASQUERADE and old
connection hanging around in the netfilter bugzilla, it's not
neccessarily the same bug as the one that's fixed in later kernels.
https://bugzilla.netfilter.org

-- 
/Martin
