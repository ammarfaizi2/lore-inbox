Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbRGKLgD>; Wed, 11 Jul 2001 07:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbRGKLfy>; Wed, 11 Jul 2001 07:35:54 -0400
Received: from [194.213.32.142] ([194.213.32.142]:15620 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267278AbRGKLfp>;
	Wed, 11 Jul 2001 07:35:45 -0400
Message-ID: <20010710235013.A1933@bug.ucw.cz>
Date: Tue, 10 Jul 2001 23:50:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI S1 and keyboard
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With latest ACPI and patrick's patches, S1 *somehow* works. I can
enter it, and can exit it, userland is still alive, but all hardware
devices are dead.

But patrick's code explicitely does not resume devices when returning
from S1:

        if (state > ACPI_SLEEP_S1)
                pm_send_all(PM_RESUME,(void*)0);

Does that mean my hardware is buggy, or is something wrong with
interrupts?

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
