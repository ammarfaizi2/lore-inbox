Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTLWSiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTLWSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:38:52 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:21132 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262111AbTLWSiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:38:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org
Subject: Re: synaptics mouse jitter in 2.6.0
Date: Tue, 23 Dec 2003 13:37:14 -0500
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0312222127530.18261@localhost.localdomain> <200312230241.52168.dtor_core@ameritech.net> <pan.2003.12.23.08.37.38.378082@voxel.net>
In-Reply-To: <pan.2003.12.23.08.37.38.378082@voxel.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312231337.14082.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 03:37 am, Andres Salomon wrote:

> [...]
>
> This works a lot better than both -mm1 and stock 2.6.0's mouse behavior
> for me; 2.6.0 likes to drop packets inside the interrupt handler and
> make the mouse jump to the edge of the screen, and 2.6.0-mm1 likes to
> move the pointer between the time I take my finger off the touchpad and
> hit the mouse button.  This appears to fix both issues; however, I
> still see the following in logs:
>
> Dec 23 03:33:53 spiral kernel: Synaptics driver lost sync at byte 4
> Dec 23 03:33:53 spiral kernel: Synaptics driver lost sync at byte 1
> Dec 23 03:33:53 spiral kernel: Synaptics driver resynced.
> Dec 23 03:33:55 spiral kernel: Synaptics driver lost sync at byte 1
> Dec 23 03:33:55 spiral last message repeated 4 times
> Dec 23 03:33:55 spiral kernel: Synaptics driver resynced.
>

That is a known issue with ACPI and i8042 (you do use ACPI, don't you?)
that we were not able to pinpoint yet. The solution that helps a bit is
to poll battery state/tepmerature less frequently.

Dmitry
