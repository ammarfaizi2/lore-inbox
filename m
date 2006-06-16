Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWFPTpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWFPTpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWFPTpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:45:46 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:51869 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP
	id S1751466AbWFPTpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:45:46 -0400
Date: Fri, 16 Jun 2006 12:43:30 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
cc: Willy Tarreau <w@1wt.eu>, Avuton Olrich <avuton@gmail.com>,
       Horst von Brand <vonbrand@inf.utfs.cl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
In-Reply-To: <448F903F.9070108@ens-lyon.org>
Message-ID: <Pine.LNX.4.63.0606161218590.2398@bigred.russwhit.org>
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
 <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com>
 <448F8C53.5010406@ens-lyon.org> <20060614042007.GD13255@w.ods.org>
 <448F903F.9070108@ens-lyon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Jun 2006, Brice Goglin wrote:

> Willy Tarreau wrote:
>> On Wed, Jun 14, 2006 at 12:10:59AM -0400, Brice Goglin wrote:
>>
>>> Avuton Olrich wrote:
>>>
>>>> On 6/13/06, Russell Whitaker <russ@ashlandhome.net> wrote:
>>>>
>>>>> Then, after mrproper, rebuilt with gcc-4.1.1, no other changes.
>>>>>    compiles ok, installs ok. But, when attempting to load a module, get
>>>>>    the following message:  version magic '2.6.16.19via K6 gcc-4.1',
>>>>>    should be '2.6.16.19via 486 gcc-3.3'
>>>>>
>>>> You may have forgotten to "make modules modules_install"
>>>>
Problem solved:

The original installation, Slackware, uses "/vmlinuz". The kernel build
uses "/boot/vmlinuz" and the original lilo.config without checking to see
if there is a "/boot/vmlinuz" in it. Thus on reboot the system is trying 
to match the old kernel with the new modules.

A warning message would have been nice.

Thanks, all, for the help.
   russ
