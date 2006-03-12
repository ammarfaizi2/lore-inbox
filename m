Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWCLVOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWCLVOP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCLVOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:14:15 -0500
Received: from bizon.gios.gov.pl ([212.244.124.8]:9618 "EHLO bizon.gios.gov.pl")
	by vger.kernel.org with ESMTP id S1751234AbWCLVOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:14:15 -0500
Date: Sun, 12 Mar 2006 22:13:59 +0100 (CET)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>,
       Suresh B Siddha <suresh.b.siddha@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
In-Reply-To: <20060312073524.A9213@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
 <20060311210353.7eccb6ed.akpm@osdl.org> <Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
 <20060312032523.109361c1.akpm@osdl.org> <Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>
 <20060312073524.A9213@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1570438749-1142198039=:19689"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1570438749-1142198039=:19689
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 12 Mar 2006, Venkatesh Pallipadi wrote:

> On Sun, Mar 12, 2006 at 02:05:00PM +0100, Krzysztof Oledzki wrote:
>>
>>
>> On Sun, 12 Mar 2006, Andrew Morton wrote:
>>
>>> Krzysztof Oledzki <olel@ans.pl> wrote:
>>>>
>>>> On Sat, 11 Mar 2006, Andrew Morton wrote:
>>>>
>>>>> Krzysztof Oledzki <olel@ans.pl> wrote:
>>>>>>
>>>>>> After upgrading to 2.6.16-rc6 I noticed this strange message:
>>>>>>
>>>>>>  More than 8 CPUs detected and CONFIG_X86_PC cannot handle it.
>>>>>>  Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.
>>>>>>
>>>>>> This is a Dell PowerEdge SC1425 with two P4 Xeons with HT enabled (s=
o with
>>>>>>  totoal of 4 logical CPUs).
>>>>>
>>>>> Please send full dmesg output for the failing kernel, thanks.
>>>>  Attached.
>>>>
>>>>> Which is the most-recently-tested kernel which behaved correctly?
>>>>  2.6.15.6
>>>
>>> OK, thanks.  I assume the machine's working OK?
>>
>> Yes. So far no problems, only this warning.
>>
>>> From my reading, you have CONFIG_HOTPLUG_CPU enabled and the machine ha=
s an
>>> APIC.
>> That is correct.
>>
>>> I'd expect that lots of people would hit that warning but for some
>>> reason they don't - possibly because most APICs don't have sufficiently
>>> high version numbers?
>>>
>
> Actually, this warning should be seen on many other systems on well. We
> use the bigsmp when there _or_ more than 8 CPUs or CPU_HOTPLUG is used.
> So, in that sense the message is wrong, it should also have CPU_HOTPLUG i=
n
> there. Or we should make CPU_HOTPLUG depend on GENERIC_ARCH or auto selec=
t
> GENERIC_ARCH with hotplug at the CONFIG level.

Why? I have exactly 4 HT CPUs (2 cores), no more. I use CPU hotplug so I=20
can disable or enable any of them when I want to. So, this is a classic=20
SMP system and 2.6.15 is totally happy with this. Or is there any other=20
(better?) way to disable/enable CPU (especially second logical CPU from=20
HT) on running systems?

Best regards,

 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1570438749-1142198039=:19689--
