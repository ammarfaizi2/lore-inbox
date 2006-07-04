Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWGDKEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWGDKEk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWGDKEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:04:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30699 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932201AbWGDKEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:04:39 -0400
Date: Tue, 4 Jul 2006 10:50:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems porting asus_acpi to LED subsystem
Message-ID: <20060704085022.GB1755@elf.ucw.cz>
References: <20060703203958.GA8093@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703203958.GA8093@phoenix>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Summary:
> 
> I'm trying to link asus_acpi into the LED subsystem.  My set_brightness
> callback evaluates an ACPI method to set the LED state.  It works fine
> manually changing the brightness, but when the callback is called by a
> timer (using the timer or ide-disk triggers), it eventually causes an
> Oops.  I can post my code or the Oops if it would help.  I'm new at
> kernel coding, and I'm not on the list, so please CC me on any reply.
> Sorry if this isn't appropriate on the list.

I _guess_ the LED subsystem can be called from interrupt, and ACPI
does not like that. So you probably need to use workqueue to defer
setting a bit.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
