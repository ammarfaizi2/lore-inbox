Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbUKQA1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUKQA1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 19:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbUKQAG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 19:06:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262134AbUKPXu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:50:28 -0500
Date: Tue, 16 Nov 2004 18:50:09 -0500
From: Dave Jones <davej@redhat.com>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi_power_off issue in 2.6.10-rc2-mm1
Message-ID: <20041116235009.GG8674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 11:10:03PM +0000, Marcos D. Marado Torres wrote:

 > In 2.6.10-rc2 and previous kernels acpi_power_off allways worked fine, but 
 > in
 > 2.6.10-rc2-mm1 when I do 'halt' all runs fine, the last message 
 > "acpi_power_off
 > called. System is going to power off" (something like this, I don't recall
 > ^-^;) appears, but then the machine just doesn't power off.
 > 
 > This is happening with an ASUS M3N laptop, I guess that it's a problem
 > somewhere in
 > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/broken-out/bk-acpi.patch
 > When I get some time I'll take a deeper look into it...

This one has been around for a while. It's been plagueing me since 2.6.8,
though its interesting that you only see it happening recently.

My attempts to debug it led to the bug disappearing when I added
instrumentation to the kernel.  On my Compaq Evo, it does power off
eventually, though it takes about a minute after that last
acpi_power_off message.

There are bugs open on this in bugme.osdl.org, and bugzilla.redhat.com

http://bugme.osdl.org/show_bug.cgi?id=3642
https://bugzilla.redhat.com/beta2/show_bug.cgi?id=acpi_power_off

		Dave

