Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbQKVGAG>; Wed, 22 Nov 2000 01:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbQKVF75>; Wed, 22 Nov 2000 00:59:57 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:19471 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S130607AbQKVF7s>;
	Wed, 22 Nov 2000 00:59:48 -0500
Date: Wed, 22 Nov 2000 13:59:47 -0500
From: Zach Brown <zab@zabbo.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI interface
Message-ID: <20001122135947.D14640@tetsuo.zabbo.net>
In-Reply-To: <20001121150246.A5608@adam.yggdrasil.com> <3A1B06B7.610AEE5A@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A1B06B7.610AEE5A@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Nov 21, 2000 at 06:35:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unrelated to your change:  the maestro reboot notifier shouldn't need to
> unregister all that stuff.  Who cares if the sound devices are freed,
> since we are rebooting.  free_irq+maestro_power seems sufficient.  or
> maybe stop_dma+free_irq+poweroff.

its only the power stuff that matters.  some biosen don't power down
properly if the chip isn't powered down.  That could actually be because
of weird changes we make to the chip and then mask by powering it down,
but shutting it down made the machines halt again :)

-- 
 zach
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
