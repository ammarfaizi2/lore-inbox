Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269740AbUHZXJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269740AbUHZXJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHZXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:09:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:41947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269688AbUHZXCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:02:39 -0400
Date: Thu, 26 Aug 2004 16:02:04 -0700
From: Greg KH <greg@kroah.com>
To: ismail d?nmez <ismail.donmez@gmail.com>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.org
Subject: Re: 2.6.8.1-mm1 Tty problems?
Message-ID: <20040826230204.GD12762@kroah.com>
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <412272C8.6050203@microgate.com> <1092778561.8998.18.camel@nosferatu.lan> <2a4f155d040817224449ef0874@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4f155d040817224449ef0874@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 08:44:28AM +0300, ismail d?nmez wrote:
> On Tue, 17 Aug 2004 23:36:02 +0200, Martin Schlemmer <azarah@nosferatu.za.org> 
> > He has the wrong permissions in
> > /etc/udev/permissions.d/50-udev.permissions (or whatever), or no
> > entry for it, and his default_mode (in /etc/udev/udev.conf) is very
> > restrictive, or he does not use pam_console (or using it with a
> > display manager?), or add some other explanation.  Personally I would
> > just say that he/his_distribution should fix the shipped
> > udev.permissions.
> 
> I run Slackware 10 and got this in /etc/udev/permissions.d/udev.permissions :
> 
> # console devices
> console:root:tty:0600
> tty:root:tty:0666
> tty[0-9][0-9]*:root:tty:0660
> vc/[0-9]*:root:tty:0660
> 
> 
> But the real problem is not permissions but the fact that /dev/tty is
> a directory now not a character device. Is this intended? If yes this
> will break many userspace applications which will assume /dev/tty is a
> character device. Greg can you please comment?

/dev/tty is a char device on my system.  Perhaps your rules files are
making that not happen properly.

thanks,

greg k-h
