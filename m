Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTFQO7C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFQO7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:59:02 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:50762 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264788AbTFQO64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:58:56 -0400
Subject: Re: ACPI broken... again!
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030617144443.GA27558@codeblau.de>
References: <20030617144443.GA27558@codeblau.de>
Content-Type: text/plain
Message-Id: <1055862728.15330.16.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 17 Jun 2003 11:12:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 10:44, Felix von Leitner wrote:
> Linux 2.5.70 and above have broken ACPI.  Again.  This is my fifth
> machine on which I try ACPI, two notebooks and three desktops, chipsets
> from Intel, VIA and SiS, no matter, ACPI still breaks 'em all.
> Why oh why is ACPI so horrendously broken?

Because its a moderately bad spec that your vendor implemented to deal
with a horrid redmond interpreter.  (And, to make things worse, the
linux-acpi team specifically insists on implementing the spec, not the
reality. "We refuse to be bug-for-bug compatible with the other major
implementation."  So linux-acpi is "right" but redmond-acpi is tested
and actually works.)

> And more to the point: if it _is_ this broken, why ship it at all?  I
> don't recall a single moment where ACPI did anything good for me, only

I'm kinda fond of battery status. And pci interrupt routing (convenient,
that..) and the half-dozen or so important other functions that even a
half-broken ACPI provides on my main machine (laptop, no APM support at
all.)  And as a side note, especially on laptops, the DSDT (bios "talk
to acpi-managed hardware like this" bytecode) tends to be dramatically
broken.  acpi.sf.net has info on patching it, some pre-patched tables,
etc.

Hate it? Well... that'd be why its a configure option.

-- 
Disconnect <lkml@sigkill.net>

