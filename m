Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWGBOwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWGBOwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 10:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWGBOwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 10:52:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57063 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932207AbWGBOwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 10:52:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, stsp@aknet.ru, linux-kernel@vger.kernel.org
Subject: Re: the creation of boot_cpu_init() is wrong and accessing uninitialised data
References: <1151376313.3443.12.camel@mulgrave.il.steeleye.com>
	<20060626200433.bf0292af.akpm@osdl.org>
	<1151379392.3443.20.camel@mulgrave.il.steeleye.com>
	<20060626220337.06014184.akpm@osdl.org>
	<1151419746.3340.13.camel@mulgrave.il.steeleye.com>
	<20060627170446.30392b00.akpm@osdl.org>
	<1151462735.5793.2.camel@mulgrave.il.steeleye.com>
	<20060627195743.ce18afe3.akpm@osdl.org>
	<1151536204.3377.51.camel@mulgrave.il.steeleye.com>
	<1151600336.6186.9.camel@mulgrave.il.steeleye.com>
Date: Sun, 02 Jul 2006 08:52:02 -0600
In-Reply-To: <1151600336.6186.9.camel@mulgrave.il.steeleye.com> (James
	Bottomley's message of "Thu, 29 Jun 2006 12:58:55 -0400")
Message-ID: <m1zmfs83fx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> On Wed, 2006-06-28 at 19:10 -0400, James Bottomley wrote:
>> I'm still compiling, so might have the results later this evening.
>
> Actually, ran into a 53c700 driver problem, but I can now verify that
> this patch works on voyager when booting with a non-zero CPU.

What is the point of using a non-zero logical cpu id?
I don't care about the apic id or the equivalent.

There are cases like machine_shutdown where we care about who
the boot cpu is so we can reboot on that cpu.  As far as I know 
the kernel has not abstraction to describe the boot cpu
except for giving it logical cpu id 0.  Has an abstraction
been added that I'm not aware of?

Eric
