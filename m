Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUGLDlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUGLDlW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUGLDlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:41:22 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:32599 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264860AbUGLDlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:41:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: synaptics driver
Date: Sun, 11 Jul 2004 22:41:18 -0500
User-Agent: KMail/1.6.2
Cc: Ari Pollak <ajp@aripollak.com>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080155.38937.dtor_core@ameritech.net> <ccsvrq$frj$1@sea.gmane.org>
In-Reply-To: <ccsvrq$frj$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407112241.18914.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 July 2004 10:17 pm, Ari Pollak wrote:
> Hi again. I just wanted to let you know that under 2.6.8-mm1, I'm still 
> experiencing the same synaptics-not-being-detected-at-system-startup bug 
> that happens with the newer input patches since earlier -mm kernels. 
> Sometimes my synaptics touchpad will get detected correctly (generally 
> after a cold reboot) and both my trackpoint & touchpad will work 
> properly, but other times (after warm reboot usually) the trackpoint 
> won't work, and the Synaptics X driver won't enable the extra touchpad 
> features. Removing & reloading the psmouse module after the system has 
> booted fixes the problem. With the more recent kernels, this seems to 
> happen even if psmouse is loaded before all the USB controller modules.
>

Usually that happens because of USB Legacy emulation screws up Synaptics
detection. You need to load your USB modules _before_ loading psmouse so
uhci (or ohci) would disable the legacy mode before psmouse starts
detection.

-- 
Dmitry
