Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTDWHrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 03:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTDWHrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 03:47:25 -0400
Received: from [81.80.245.157] ([81.80.245.157]:42968 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S263980AbTDWHrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 03:47:24 -0400
Date: Wed, 23 Apr 2003 09:59:17 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423075917.GC820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 03:47:32PM -0300, Marcelo Tosatti wrote:

> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.
[...]
> Ben Collins <bcollins@debian.org>:
>   o IEEE-1394/Firewire update

Something gone wrong with this changes. My Sony Vaio Picturebook C1VE
hangs on boot when the firewire controller is probed by the init
scripts.

This happens exactly in the sequence:
	modprobe ohci1394
	grep something /proc/bus/ieee1394/devices
I'm not sure yet if the lockup is related to the ohci1394 initialisation
or the read in /proc possibly eariler than the driver expects.

The kernel still reacts to sysrq (umount/sync etc), however task/memory/pc
sysrq function do NOT work...

I'll investigate a bit further on this today.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
