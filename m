Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265112AbUFWQJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbUFWQJZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUFWQI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:08:26 -0400
Received: from web81308.mail.yahoo.com ([206.190.37.83]:50798 "HELO
	web81308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265790AbUFWQHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:07:44 -0400
Message-ID: <20040623160742.13669.qmail@web81308.mail.yahoo.com>
Date: Wed, 23 Jun 2004 09:07:42 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: [RFC/RFT] PS/2 mouse resync for KVM users
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horzon.com wrote:
> > - flag "suspect" packets - 1st bytes with overflow bits set and bytes
> that
> >   indicate that Left + Middle or Right + Middle  buttons are pressed at
> the
> >   same time which is unusial combination. Suspect packets, together with
> >   timeouts, are treated as "soft" errors.
> 
> I'm a little unhappy with this.   They are *currently* unusual, but
> I hate to preclude anyone from using them.

I also had some concerns, it's not the final patch version by any
means... Your suggestions are very interesting and I will try to
implement some of them (acceleration and "suspicion scoring" is a
bit of overkill I think), but I like the "unusial combination" idea
because you can trigger reconnect _at will_. Although with my sysfs
patches one could do it by echoing reconnect to driver attribute of
corresponding serio port ability just hold couple of buttons and
wiggle mouse and have it restore connection seems to be nice.

What if we trigger packets with all 3 buttons pressed as suspect?

--
Dmitry
