Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268646AbUHRFod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268646AbUHRFod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 01:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUHRFod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 01:44:33 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:47651 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268646AbUHRFo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 01:44:29 -0400
Message-ID: <2a4f155d040817224449ef0874@mail.gmail.com>
Date: Wed, 18 Aug 2004 08:44:28 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <1092778561.8998.18.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2a4f155d040817070854931025@mail.gmail.com>
	 <412247FF.5040301@microgate.com>
	 <2a4f155d0408171116688a87f1@mail.gmail.com>
	 <4122501B.7000106@microgate.com>
	 <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <412272C8.6050203@microgate.com> <1092778561.8998.18.camel@nosferatu.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 23:36:02 +0200, Martin Schlemmer <azarah@nosferatu.za.org> 
> He has the wrong permissions in
> /etc/udev/permissions.d/50-udev.permissions (or whatever), or no
> entry for it, and his default_mode (in /etc/udev/udev.conf) is very
> restrictive, or he does not use pam_console (or using it with a
> display manager?), or add some other explanation.  Personally I would
> just say that he/his_distribution should fix the shipped
> udev.permissions.

I run Slackware 10 and got this in /etc/udev/permissions.d/udev.permissions :

# console devices
console:root:tty:0600
tty:root:tty:0666
tty[0-9][0-9]*:root:tty:0660
vc/[0-9]*:root:tty:0660


But the real problem is not permissions but the fact that /dev/tty is
a directory now not a character device. Is this intended? If yes this
will break many userspace applications which will assume /dev/tty is a
character device. Greg can you please comment?

Cheers,
ismail

-- 
Time is what you make of it
