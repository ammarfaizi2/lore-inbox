Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSDSIII>; Fri, 19 Apr 2002 04:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDSIIH>; Fri, 19 Apr 2002 04:08:07 -0400
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:53767 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S311829AbSDSIIH>; Fri, 19 Apr 2002 04:08:07 -0400
Date: Fri, 19 Apr 2002 10:08:02 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: private fops plug-in point
Message-ID: <Pine.LNX.4.33.0204190952180.15512-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[kernel-bloat_argument_awareness_on]

Hello

An idea: I presume, I am not the first and not the only one, who wants to
add some arch / implementation features to some driver, being absolutely
sure, even a possibility of such a extension would never make it into the
kernel and rightly so - there's no need for it there. So, I believe, most
of people in this situation just create (and maintain) a local
kernel-patch. That's fine, but somewhat ugly. So, the idea is - wouldn't
it be useful to have some private fops plug-in points in "all"
(shields_maximum_power) device drivers. E.g., a driver open function would
check if the device' private_fops.open pointer is not NULL and then run
that function. A good point, perhaps, would be after all normal actions
are done. But, I am sure, some users would want to do some stuff BEFORE
standard actions... Asking for 2 plug-in points would be FAR TOO impudent
of me:-) Then it would just suffice to load a module to add some specific
actions to a specific driver / function... Maybe a
CONFIG_EXTENDIBLE_KERNEL option could be used to switch these plug-in
points on / off... That would avoid any overhead at all. Ok, some
performance-critical drivers / functions may chose not to include these
plug-in points at all. Just a raw idea. Any improvements most welcome.

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

