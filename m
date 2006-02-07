Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWBGNHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWBGNHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWBGNHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:07:00 -0500
Received: from tim.rpsys.net ([194.106.48.114]:8851 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965065AbWBGNG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:06:59 -0500
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
From: Richard Purdie <rpurdie@rpsys.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207123204.GA1423@srcf.ucam.org>
References: <20060206191506.GA17395@srcf.ucam.org>
	 <20060206191916.GB17460@srcf.ucam.org>
	 <20060207003748.GA22510@srcf.ucam.org>
	 <200602062237.55653.dtor_core@ameritech.net>
	 <20060207123204.GA1423@srcf.ucam.org>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 13:06:45 +0000
Message-Id: <1139317605.6422.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 12:32 +0000, Matthew Garrett wrote:
+       /* The backlight interface doesn't give us a means of providing
+          more than one brightness value, so we put the AC value in the
+          top bits of the brightness and the DC value in the bottom bits */

This is total abuse of the backlight class. The idea is that
cat /sys/class/backlight/ccc/brightness returns the *current* backlight
brightness. On AC power it should return the AC brightness value and on
DC power return the DC value.

If you want to know the DC and AC values as stored in the BIOS they
should be device specific attributes, not generic class ones.

I have a patch in the pipeline to change the backlight class slightly to
provide both the user requested brightness and the current brightness as
the two can differ (the Zaurus handhelds limit the backlight intensity
on low power).

Richard



