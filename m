Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVAAP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVAAP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 10:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVAAP4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 10:56:24 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:49350 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261152AbVAAP4V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 10:56:21 -0500
Message-ID: <41D6C81F.1090106@drzeus.cx>
Date: Sat, 01 Jan 2005 16:56:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APIC, changing level/edge interrupt
References: <41D1977D.2000600@drzeus.cx> <20050101054925.GA13925@hockin.org>
In-Reply-To: <20050101054925.GA13925@hockin.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:

>On Tue, Dec 28, 2004 at 06:27:25PM +0100, Pierre Ossman wrote:
>  
>
>>How do you tell the APIC that a device uses level triggered interrupts, 
>>not edge triggered? I have a flash reader on the LPC bus which uses 
>>level triggered interrupts and /proc/interrupts show edge triggered. 
>>Some interrupts are missed by the APIC so I figured this might be why.
>>    
>>
>
>BIOS should set this up.  Maybe ACPI has a way to do this?
>  
>
Should doesn't always mean that it actually does ;)
But since BIOS can configure the APIC then the kernel should be able to 
also. A quick and dirty hack will suffice ATM since I just want to 
pinpoint where the problem is.
What is the default mode and what does the XT-PIC expect? (it works fine 
with the apic disabled).

ACPI might have some functions to configure the APIC correctly but right 
now the connection between ACPI and drivers is rather weak (non-existant 
for this driver) so that's not really a viable solution when testing. 
Might be a good long term solution though.

Rgds
Pierre

