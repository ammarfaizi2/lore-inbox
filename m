Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263098AbVD3AzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbVD3AzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbVD3AzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:55:21 -0400
Received: from scrye.com ([216.17.180.1]:18919 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S263098AbVD3Ayn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:54:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Apr 2005 18:54:38 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Subject: Re: Problems with Centrino frequency modulation
X-Draft-From: ("scrye.linux.kernel" 4880)
References: <d4uhce$hme$1@sea.gmane.org>
Message-Id: <20050430005439.4F644454359@ningauble.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joshua" == Joshua Kwan <joshk@triplehelix.org> writes:

Joshua> Hello!  I'm running 2.6.11.7 on an IBM Thinkpad T42. APM is
Joshua> working out very nicely in everything except clock modulation,
Joshua> which seems to require ACPI before speedstep-centrino will see
Joshua> it. p4-clockmod is able to wrangle the CPU, but it warns that
Joshua> I should really be using speedstep-centrino as p4-clockmod
Joshua> can't change the CPU voltage.

Joshua> My CPU is family 6 / model 13 / stepping 6 (CPU_DOTHAN_B0 in
Joshua> speedstep-centrino.c.) Is there a way to get
Joshua> speedstep-centrino working without having to use the wretched
Joshua> ACPI (which, among other things, prevents -- or at least makes
Joshua> it a large magnitude harder to -- sleep.  If I do echo 3 >
Joshua> /proc/acpi/sleep or echo mem > /sys/power/state, it sleeps
Joshua> correctly, but will wake up with a blank screen or a
Joshua> completely white one. [Observant readers will notice this is
Joshua> exactly what I reported with my last laptop and I'm
Joshua> disappointed to notice that the problem is not restricted to
Joshua> that POS.]) Therefore, I really, really don't want to use
Joshua> ACPI.

Not that you want to hear it, but I have a T42p (that I just got a few
weeks ago) and it can do S3 suspend/resume just fine.

There are 3 things you need to do: 

boot with: "acpi_sleep=s3_bios"

rmmod all the usb modules before suspending. 

do not use the binary only ati drivers. 

I use the hibernate script from the suspend2 project: 
http://suspend2.net/
set to do S3 instead of suspend2, which also unloads blacklisted
modules (Including the usb ones) and re-loads them on resume. 

You might try that if you get a chance. ACPI has come a long way... 

Joshua> Thanks.
Joshua> -- Joshua Kwan

kevin

