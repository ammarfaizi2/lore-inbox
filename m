Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHPATf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHPATf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWHPATf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:19:35 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49551 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750721AbWHPATf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:19:35 -0400
Subject: Re: peculiar suspend/resume bug.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060815221035.GX7612@redhat.com>
References: <20060815221035.GX7612@redhat.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 10:19:59 +1000
Message-Id: <1155687599.3193.12.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave.

On Tue, 2006-08-15 at 18:10 -0400, Dave Jones wrote:
> Here's a fun one.
> - Get a dual core cpufreq aware laptop (Like say, a core-duo)
> - Add a cpufreq monitor to gnome-panel. Configure it
>   to watch the 2nd core.
> - Suspend.
> - Resume.
> 
> Watch the cpufreq monitor die horribly.
> 
> I believe this is because we take down the 2nd core at suspend
> time with cpu hotplug, and for some reason we're scheduling
> userspace before we bring that second core back up.
> 
> Anyone have any clues why this is happening?

If you hotunplug and replug the cpu using the sysfs interface, rather
than suspending and resuming, does the same thing happen?

Regards,

Nigel

