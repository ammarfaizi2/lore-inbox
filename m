Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUB0Lmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUB0Lmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:42:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:8084 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261686AbUB0Lml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:42:41 -0500
X-Authenticated: #22280117
Date: Fri, 27 Feb 2004 12:45:12 +0100
From: Bernhard Gruber <bernig@gmx.at>
X-Mailer: The Bat! (v1.62 Christmas Edition) Personal
Reply-To: Bernhard Gruber <bernig@gmx.at>
X-Priority: 3 (Normal)
Message-ID: <185903078.20040227124512@gmx.at>
To: linux-kernel@vger.kernel.org
Subject: /dev/psaux-Interface
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Story:
As Windows2000 was just so unstable and slow I decided to use Linux on
my Thinkpad 570E. Installation of gentoo was no problem (even if it
took quite long) and I first installed a 2.4.25-kernel. Everything
worked fine there and I could use the trackpoint utilities from Till
Straumann to set the features of the trackpoint. The only problem was,
that ACPI (and APM) did not function properly and so I couldn't get the
current state of the battery (which is quite a large problem for a
laptop). So I tried the 2.6.3-kernel. Apart from minor problems which
could be solved rather quickly I got all devices up and running
including battery monitoring. However, the trackpoint utility did not
work anymore and so the special features like press-to-select and
HARDWARE sensitivity setup do not work until today.

Problem:
As I've read so far, the approach in 2.6.x-kernel was to remove
user-space-drivers as much as possible and one of the consequences was
that the /dev/psaux-Device does not exist as in 2.4.x-kernels. However,
there are some special devices (not only the trackpoint but also
touchscreens for example) which had drivers for 2.4.x-kernels using the
/dev/psaux-interface and most people who programmed those drivers either
don't have the time or don't use/own those devices anymore. Furthermore,
writing kernel device drivers requires more skill and they are harder
to debug. So there's no real hope that they will  ever be ported...

Suggestion:
I would suggest using a /dev/psaux-compatibility option which gives back
the old interface so that these drivers work. This is only meant as a
user-selectable option and I don't think that the new input system
should be changed apart from that! There is already an existing approach
to a kernel patch which can be found here
http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/ It can be
integrated easily into the kernel but it seems like there are still bugs
in there. I'm in contact with the author because the trackpoint utilities
creates a segmentation fault when writing to the device but we could not
figure out a solution yet (it’s strange that his touchscreen device
functions without any problems). We are sure that it would not be a huge
problem to solve it for you guys out there, so if anyone wants to help us
please contact b-gruber[at]gmx.de and I’ll send you a more detailed error
report.


PS: Sorry if my english sounds a little bit bumpy sometimes but I don’t
speak english natively.
I would appreciate if you could cc all answers to my Email-adress as I
haven't subscribed to this mailing-list!

