Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVG1Gq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVG1Gq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 02:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVG1Gq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 02:46:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:12011 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S261284AbVG1Gqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 02:46:54 -0400
Date: Thu, 28 Jul 2005 08:49:38 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: system freezes for 0.2 to 0.5 seconds when reading
 /proc/acpi/thermal_zone/THRM/temperature
Message-ID: <20050728084938.480b46d1@localhost>
In-Reply-To: <20050727161605.5711fcf7.akpm@osdl.org>
References: <20050728002244.5163ac4a@localhost>
	<20050727161605.5711fcf7.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.13cvs2 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 27 Jul 2005 16:16:05 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Florian Engelhardt <flo@dotbox.org> wrote:
> >
> > Hello,
> > 
> > first of all, sorry for the long headline.
> > second:
> > Every time, i try to do the following:
> > cat /proc/acpi/thermal_zone/THRM/temperature
> > the whole system looks up for a short period of time (something
> > about 0.5s). realy everything, video and audio encoding, mouse and
> > keyboard input, firefox playing a flash animation, ...
> > I am also getting the following:
> > Losing some ticks... checking if CPU frequency changed.
> > 
> > maybe these two things are belonging to each other.
> > 
> > I am using a 2.6.12-rc3-mm1 kernel on a amd64 with a nvidia nforce4
> > mainboard.
> 
> It might help if you were to generate a kernel profile:
> 
> readprofile -r

returns:
/proc/profile: No such file or directory

do i have to activate something special during kernel configuration?

btw: i saw that mm2 is available. Are there any changes in it, which
could solve this problem?

flo

> for i in $(seq 10)
> do
> 	cat /proc/acpi/thermal_zone/THRM/temperature
> done
> readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40
> 
> 


-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
