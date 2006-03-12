Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWCLNFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWCLNFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 08:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWCLNFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 08:05:17 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:18919 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S932159AbWCLNFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 08:05:15 -0500
Date: Sun, 12 Mar 2006 14:05:00 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Suresh B Siddha <suresh.b.siddha@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
In-Reply-To: <20060312032523.109361c1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
 <20060311210353.7eccb6ed.akpm@osdl.org> <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
 <20060312032523.109361c1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-976539671-1142168700=:31039"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-976539671-1142168700=:31039
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 12 Mar 2006, Andrew Morton wrote:

> Krzysztof Oledzki <olel@ans.pl> wrote:
>>
>> On Sat, 11 Mar 2006, Andrew Morton wrote:
>>
>> > Krzysztof Oledzki <olel@ans.pl> wrote:
>> >>
>> >> After upgrading to 2.6.16-rc6 I noticed this strange message:
>> >>
>> >>  More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>> >>  Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
>> >>
>> >> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (so=
 with
>> >>  totoal of 4 logical CPUs).
>> >
>> > Please send full dmesg output for the failing kernel, thanks.
>>  Attached.
>>
>> > Which is the most-recently-tested kernel which behaved correctly?
>>  2.6.15.6
>
> OK, thanks.  I assume the machine's working OK?

Yes. So far no problems, only this warning.

> From my reading, you have CONFIG_HOTPLUG_CPU enabled and the machine has =
an
> APIC.
That is correct.

> I'd expect that lots of people would hit that warning but for some
> reason they don't - possibly because most APICs don't have sufficiently
> high version numbers?
>
> Anyway, various people cc'ed.  I _think_ it's harmless, although the way =
in
> which def_to_bigsmp propagates into the DMI and APIC code might be a
> problem, depending upon config options.
>
> Certainly the warning is incorrect, but I'm not sure what is the best thi=
ng
> to do about it?

OK. Thank you.

Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-976539671-1142168700=:31039--
