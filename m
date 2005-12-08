Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVLHXR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVLHXR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVLHXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:17:27 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60434 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932299AbVLHXR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:17:27 -0500
Date: Thu, 8 Dec 2005 23:17:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Message-ID: <20051208231717.GB9357@flint.arm.linux.org.uk>
Mail-Followup-To: Jean Delvare <khali@linux-fr.org>,
	Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com> <20051207180842.GG6793@flint.arm.linux.org.uk> <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com> <20051207190352.GI6793@flint.arm.linux.org.uk> <d120d5000512071418q521d2155r81759ef8993000d8@mail.gmail.com> <20051207225126.GA648@kroah.com> <d120d5000512071459s9b461d8ye7abc41d0e1950fd@mail.gmail.com> <20051207230615.GB742@kroah.com> <20051207232105.GO6793@flint.arm.linux.org.uk> <20051208215815.3d001dab.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208215815.3d001dab.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:58:15PM +0100, Jean Delvare wrote:
> Hi Russell,
> 
> > On Wed, Dec 07, 2005 at 03:06:15PM -0800, Greg KH wrote:
> > > Ok, that's fine with me.  Russell, any objections?
> > 
> > None what so ever - that's mostly what I envisioned with the patch
> > with the _del method.  However, I didn't have an existing user for it.
> 
> Do you mean you have the code already? If it is so, could you please
> provide a patch Dmitry and I can give a try to?

No; I mean I _had_ the code, and it could probably be dug out, but
subsequent patch revisions removed it.  It's probably archived in a
mail somewhere.

> If not, I am willing to give it a try, if you provide some guidance. I
> think I understand that platform_device_del would be the first half of
> platform_device_unregister, but do we then want to rebuild
> platform_device_unregister on top of platform_device_del so as to avoid
> code duplication, or not?

Yes on all counts.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
