Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUAMXHr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUAMXHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:07:47 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:54997 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265776AbUAMXHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:07:43 -0500
Date: Tue, 13 Jan 2004 23:06:05 +0000
From: Dave Jones <davej@redhat.com>
To: paul.devriendt@amd.com
Cc: pavel@ucw.cz, cpufreq@www.linux.org.uk, linux@brodo.de,
       linux-kernel@vger.kernel.org
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040113230605.GM14674@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, paul.devriendt@amd.com,
	pavel@ucw.cz, cpufreq@www.linux.org.uk, linux@brodo.de,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 04:37:13PM -0600, paul.devriendt@amd.com wrote:

 > I have a totally new driver, that I am hoping to release within about
 > a month. (I did target the end of the year, but I got distracted on
 > some other stuff). The new driver :
 >   - uses ACPI to figure out the available p-states. I have seen a *lot*
 >     of buggy BIOSs where the PSB/PST info is wrong or missing,

I've seen a ridiculous amount of broken PST's from folks running the K7 driver
too. Given the complete lack of help from some vendors[1], I think I might
add a minimal ACPI parser there too when I get time, as an alternative
source of info when the PST is obviously crap.

 > I would appreciate some advice on a question ... should I leave the old
 > non-ACPI capability there for those people who do not want to enable ACPI
 > in the kernel ? If so, is this a big ifdef, or is there a better way to do
 > it ? Or should I just say that it is dependent on ACPI, got to have ACPI ?

Part of the justification for cpufreq (at least on x86) was an alternative
for when ACPI just doesn't work, or for when folks either don't want to,
or can't run ACPI (through various other AML bugs for eg).

For minimal parsing of the ACPI P state tables, we shouldn't need the
full-blown interpretor IMO.

		Dave

