Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290465AbSAYAi0>; Thu, 24 Jan 2002 19:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290466AbSAYAiJ>; Thu, 24 Jan 2002 19:38:09 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:58246 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S290465AbSAYAiF>; Thu, 24 Jan 2002 19:38:05 -0500
Date: Thu, 24 Jan 2002 19:37:51 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: sfr@canb.auug.org.au
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre7 APM oddity with Dell Latitude C810
Message-ID: <20020125003750.GA1705@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: sfr@canb.auug.org.au, LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some time I've been using Massimo Dal Zotto's i8kutils to access
the SMM BIOS on my Dell Latitude C810.  Upon installing a 2.4.18-pre7
kernel today, I found that the CPU temperature was reported erratically
by i8kmon; the reading would jump about by up to five or six degrees,
eg four consecutive 3-second readings of 55 61 56 53.  Further -- as
far as I could tell -- the fans were now coming on and going off at
temperatures five degrees higher than the configured settings.  I've
never seen behaviour like that up to now, and on reverting to
2.4.18-pre6 I found the temperature readings moving linearly by 0-2
degrees per step as expected, and the fans switching on and off at the
right temperatures.

I downloaded 2.4.17-APM.1.diff and ran a patch -R with it before
recompiling -pre7.  With the resulting kernel, temperature readings and
fan settings are again behaving normally.

I'll gladly supply further details on request and/or help with testing,
if you want to follow this up.

-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
