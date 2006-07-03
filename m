Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWGCMsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWGCMsc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWGCMsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:48:31 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:1505 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750938AbWGCMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:48:31 -0400
X-Sasl-enc: qGqXu2rGmSQ66YFGMv7bQHOFk8Y103IMp9RJrgrXJb2Z 1151930908
Date: Mon, 3 Jul 2006 09:48:23 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060703124823.GA18821@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have now (or we are about to have, anyway) two drivers that export
accelerometer data: IBM's HDAPS, and Apple's AMS.  More accelerometer
drivers could be coming in the future.

Both drivers export one common set of data (accelerometer output), and some
extra information that is not related to acellerometers.  Both have at least
two functionality goals in common: to export accelerometer data to
userspace, and also to allow somehow for HD head parking when the
accelerometer detects a potentially incoming impact.

User­space utilities that interface to accelerometers like hdapsd and
smackpad could benefit from a common interface, so that they work with
HDAPS, AMS, and any other future accelerometer drivers.

If any kernel-space functionality needed by HDAPS and AMS is also shared, we
would have benefits there too.  Some examples I can think of are: generic HD
queue-freeze and HD head parking, and a generic acellerometer-driven
joystick event interface.  This would also enable generic userspace
notifiers that the HD heads have been parked, etc.

I am posting this message as a head's up for the two projects (HDAPS, AMS)
to make sure that they are actively aware of each other.  I do so in hope
that we can work in a joint, generic interface and port both drivers to this
new interface in the near future, and also that we can make as much
functionality shared between the two drivers as possible.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
