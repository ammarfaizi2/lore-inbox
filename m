Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161316AbWBUEYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161316AbWBUEYB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWBUEYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:24:01 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:25780 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932702AbWBUEYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:24:01 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] input: pcspkr device and driver separation
Date: Mon, 20 Feb 2006 23:23:58 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dmitry.torokhov@gmail.com, rth@redhat.com,
       Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
       "paulus@samba.org" <paulus@samba.org>
References: <20060208110815.5e70e36b.mikey@neuling.org> <d120d5000602161158x22216c4byabbe848d37ccf814@mail.gmail.com> <20060221131904.2639e00d.mikey@neuling.org>
In-Reply-To: <20060221131904.2639e00d.mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602202323.58951.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 21:19, Michael Neuling wrote:
> The current pcspkr code combines the device and driver registration.
> This patch splits these, putting the device registration in the arch
> specific code.
> 
> It seems opinion is divided as how much error checking needs to be
> done when registering the device at boot.  This patch does a BUG_ON on
> any device allocation failures for all architectures touched.  The
> PowerPC guys are happy with this.
> 


Argh! I mean to write this reply earlier...

As I said I like the patch overall, however I do not agree that BUG_ON is
appropriate here. Whatever issues with speaker device there is they do not
warrant OOPS at boot time. Speaker is not critical device so just clean up
after failure an move on. If you compare code cleaning up with code using
BUG_ON they are about the same in the end.

-- 
Dmitry
