Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263129AbTDBS5F>; Wed, 2 Apr 2003 13:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbTDBS5E>; Wed, 2 Apr 2003 13:57:04 -0500
Received: from tantale.fifi.org ([216.27.190.146]:34448 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S263126AbTDBS4d>;
	Wed, 2 Apr 2003 13:56:33 -0500
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: Mitch Adair <mitch@theneteffect.com>,
       rmiller@duskglow.com (Russell Miller), linux-kernel@vger.kernel.org
Subject: Re: subsystem crashes reboot system?
References: <200304021806.h32I6M709795@mako.theneteffect.com>
	<200304022044.27530.freesoftwaredeveloper@web.de>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 02 Apr 2003 11:07:40 -0800
In-Reply-To: <200304022044.27530.freesoftwaredeveloper@web.de>
Message-ID: <87k7ecg1kz.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <freesoftwaredeveloper@web.de> writes:

> On Wednesday 02 April 2003 20:06, Mitch Adair wrote:
> 
> > Isn't this what watchdog is for?  I think even the software
> > watchdog would catch this, then you can panic and reboot.
> 
> hm, I don't think, that watchdog will catch this, because the
> userspace-watchdog daemon will still be running properly in a crash
> case (or did I understand something wrong?)

Unless you configure it to stat your filesystems, like in:

  watchdog-device         = /dev/misc/watchdog
  realtime                = yes
  priority                = 99
  admin                   =
  file                    = /
  file                    = /var
  file                    = /usr
  ...

Phil.
