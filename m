Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136569AbREBAyi>; Tue, 1 May 2001 20:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136493AbREBAy1>; Tue, 1 May 2001 20:54:27 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33515 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S135903AbREBAyX>; Tue, 1 May 2001 20:54:23 -0400
Date: Tue, 1 May 2001 18:54:20 -0600
Message-Id: <200105020054.f420sKe17416@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: APM idle behaviour
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've been staring at the APM code and trying to figure out
some things related to idle behaviour. I'm staring at the code for
2.2.19.

My first question is why does cpu_idle() wait for 0.33 seconds of
idling before calling acpi_idle() (apm_cpu_idle() in fact)? Why not
wait less time, or more?

Another question is why do PS/2 mouse events break out of
apm_cpu_idle() whereas keyboard events do not? I've hacked
apm_cpu_idle() to increment a global counter, and then I can run a
programme to show the value of this counter. I can type in commands
and even switched between windows using a keyboard shortcut, and the
global counter doesn't increment. As soon as I move the mouse or press
a mouse key, the counter will increment.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
