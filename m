Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288974AbSAZBDq>; Fri, 25 Jan 2002 20:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288977AbSAZBDg>; Fri, 25 Jan 2002 20:03:36 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:29352 "HELO jhuml3.jhu.edu")
	by vger.kernel.org with SMTP id <S288974AbSAZBDd>;
	Fri, 25 Jan 2002 20:03:33 -0500
Date: Fri, 25 Jan 2002 20:02:13 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: apm: busy: Unable to enter requested state
To: linux-kernel@vger.kernel.org
Message-id: <1012006933.2576.19.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.1
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> apm: setting state busy
> apm: busy: Unable to enter requested state
> apm: setting state busy
> apm: busy: Unable to enter requested state

While the suspend request is being processed, the apm
driver attempts to set the power state to "busy", as
required by the APM spec.  The attempt fails, presumably
because of shortcomings in your firmware.

Is there a driver or userland process that is failing
to process the suspend event quickly?

> apm: received normal resume notify

The APM firmware appears to generate this event.
Perhaps it is timing out waiting for the OS to respond
to the suspend event with a set-power-state operation.
How long does it take for this to happen?

> and then the cpu does not cool down (I guess it is
> not shut down like it was before).

A suspended machine does more than cool down.  It does
not operate at all.



