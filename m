Return-Path: <linux-kernel-owner+w=401wt.eu-S1423037AbWLUV2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423037AbWLUV2L (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423117AbWLUV2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:28:11 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:19916 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423037AbWLUV2I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:28:08 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: IO-APIC + timer doesn't work
Date: Thu, 21 Dec 2006 13:24:44 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490731A@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IO-APIC + timer doesn't work
Thread-Index: AcclQYMfFz5zux7sRZW3UVIhfs7r5gABGzWw
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 21 Dec 2006 21:24:45.0630 (UTC)
 FILETIME=[6FC26DE0:01C72546]
X-WSS-ID: 699424170T03326298-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Thursday, December 21, 2006 12:47 PM
To: Lu, Yinghai
>> +static int add_irq_entry(int type, int irqflag, int bus, int irq,
int apic, int
>> pin)

>This is fairly sane but probably belongs in mptable.c as a helper.

mparse.c?


>I am still trying to understand this enable_8259A_irq(0) case.
>As far as I can tell this is a very backwards way of enabling
>an ExtINT, as such it shouldn't be used until later.

>YH do you have any insight why on some Nvidia chipsets we apic 0 pin 2
doesn't
>work for the timer interrupt.  I thought that was what we were using in
LinuxBIOS
>for the mptable.

CK804's has problem. But later one seems fixed that problem.

YH



