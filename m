Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUGQEbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUGQEbv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 00:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUGQEbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 00:31:51 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:24028 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S264860AbUGQEbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 00:31:50 -0400
Subject: Re: psmouse as module with suspend/resume
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kevin Fenzi <kevin-kernel@scrye.com>, Brouard Nicolas <brouard@ined.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200407161743.37577.dtor_core@ameritech.net>
References: <20040715205459.197177253D@voldemort.scrye.com>
	 <200407160058.57824.dtor_core@ameritech.net>
	 <20040716164704.CFC1A43FF@voldemort.scrye.com>
	 <200407161743.37577.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1090038217.11603.0.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 17 Jul 2004 14:23:37 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-07-17 at 08:43, Dmitry Torokhov wrote:
> I am inclined to say that it's swsusp2 problem. I briefly looked over
> the code and I could not find a place where device_power_up would be
> called; swsusp2 goes straight to device_resume. This causes system
> devices (and i8042 is currently a system device) not be resumed and
> thus your touchpad is left id default PS/2 hardware emulation mode.

Ah. I see what you mean. Pavel and Patrick have improved the support in
their versions and I still have the old code. I'll update to use the
device tree properly.

Regards,

Nigel

