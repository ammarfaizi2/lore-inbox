Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUILTTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUILTTA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268816AbUILTS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:18:59 -0400
Received: from defout.telus.net ([199.185.220.240]:33000 "EHLO
	priv-edtnes46.telusplanet.net") by vger.kernel.org with ESMTP
	id S268812AbUILTSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:18:42 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <peter@mysql.com>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local andREMOTE(verified)Denial of Service Attack
Date: Sun, 12 Sep 2004 13:18:46 -0600
Message-ID: <002801c498fd$536d33f0$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <02bd01c498fc$fe1954b0$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sul, 2004-09-12 at 19:40, Wolfpaw - Dale Corse wrote:
> > This bug also exists with Apache, the default config of SSH, and
> > anything controlled by inetd. This is the vast majority of popular 
> > services on a regular internet server.. That is bad, no?
> 
> I'm unable to duplicate any such problems with xinetd, or 
> with thttpd, or with apache. Apache will wait a short time 
> then timeout connections if you've configured it right. If 
> you can continue making millions of connections a second you 
> can DoS the server the other end, not exactly new news. The 
> alternative is that you have an infinite number of running 
> services and you run out of memory instead.

Slackware doesn't use xinetd, but rather inetd. Is inetd an
old version which is no longer maintained? Apache, it didn't
kill, but slowed it down quite a bit. You are correct for sure
on that point though, there is nothing that can be done about
connection floods.

> Thats a high level property of any protocol which allows 
> commitment of resource without being able to do the security 
> authentication first. Its very hard to create ones that don't 
> however, thus most devices in life (eg your telephone) have 
> this form or DoS attack.

Very true :(

> My sshd also doesn't show this problem and the manual page 
> indicates it has a 120 second grace timeout for authentication.
> 
> The sshd manual page says:
> 
>      Gives the grace time for clients to authenticate themselves
>              (default 120 seconds).

Again - likely a connection flooding DoS there.. Which can't be helped
Unless you use ipchains to limit the amount of connections per ip
address.

Thanks for the reply :)
D.

