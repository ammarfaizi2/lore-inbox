Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbULWJcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbULWJcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbULWJcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:32:41 -0500
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:54430 "EHLO
	anduin.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S261190AbULWJcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:32:39 -0500
From: Arnaud Patard <apatard@mandrakesoft.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: 2.6.x BUGs at boot time (APIC related)
References: <200412221731.20105.vda@port.imtp.ilyichevsk.odessa.ua>
	<200412231102.10171.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: Mandrakesoft
Date: Thu, 23 Dec 2004 10:33:28 +0100
In-Reply-To: <200412231102.10171.vda@port.imtp.ilyichevsk.odessa.ua> (Denis
 Vlasenko's message of "Thu, 23 Dec 2004 11:02:09 +0000")
Message-ID: <m2u0qdgxzr.fsf@anduin.mandrakesoft.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

> On Wednesday 22 December 2004 17:31, Denis Vlasenko wrote:
>> This is happening on a "HP Compaq dc7100 CMT"
>> (I believe it is a model number - taken from the label on the box).

iirc, dc7100 is the name of the minitower box, not of the computer :)

>>
>> Both 2.6.9 and 2.6.10-rc3 are dying this way:
>>
>> [top of visible screen]
>> I/O APIC #1 Version 17 at 0xFEC00000
>> Enabled APIC mode: Flat. Using 1 I/O APICs
>> ...
>> [unrelated stuff (dentry cache size etc...)]
>> ...
>> Enabling fast FPU save & restore ...done
>> Enabling unmasked SIMD FPU exception support ...done
>> Checking 'hlt' instruction ..OK
>> ------------------------
>> kernel BUG at arch/i386/kernel/apic.c:388! [:366! for 2.6.9]

I've taken a look at your .config for 2.6.10 and you don't have acpi
enabled (see below). Please try with acpi enabled

