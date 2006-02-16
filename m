Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWBPUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWBPUkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWBPUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:40:33 -0500
Received: from spirit.analogic.com ([204.178.40.4]:58637 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964894AbWBPUkc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:40:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20060216203007.GB17970@butterfly.hjsoft.com>
X-OriginalArrivalTime: 16 Feb 2006 20:40:31.0011 (UTC) FILETIME=[3A40B730:01C63339]
Content-class: urn:content-classes:message
Subject: Re: can't loadkeys anymore? (was Re: Linux-2.6.15.4 login errors)
Date: Thu, 16 Feb 2006 15:40:26 -0500
Message-ID: <Pine.LNX.4.61.0602161536580.4320@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: can't loadkeys anymore? (was Re: Linux-2.6.15.4 login errors)
thread-index: AcYzOTpIQp1o9wmDQIq+RLLWCJxGmg==
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com> <20060216142824.GD13188@redhat.com> <20060216203007.GB17970@butterfly.hjsoft.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "John M Flinchbaugh" <john@hjsoft.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, John M Flinchbaugh wrote:

> On Thu, Feb 16, 2006 at 09:28:25AM -0500, Dave Jones wrote:
>> On Thu, Feb 16, 2006 at 09:13:46AM -0500, linux-os (Dick Johnson) wrote:
>> > After installing linux-2.6.15.4, attempts to log in a non-root
>> > account gives these errors.
>> > Password:
>> > Last login: Thu Feb 16 08:53:20 on tty1
>> > Keymap 0: Permission denied
>> > Keymap 1: Permission denied
>> > Keymap 2: Permission denied
>> > LDSKBENT: Operation not permitted
>> > loadkeys: could not deallocate keymap 3
>> It's coming from unicode_start
>> > This is a RH Fedora base. Anybody know how to turn this crap off?
>> Apply updates.
>> This was fixed in kbd 1.12-10.fc4.1
>
> This still leaves the question: Why is loadkeys no longer permitted to
> set the keymap for a tty the user currently owns?  What if the user
> really does want to run loadkeys without having to be root (ie. to load
> dvorak keymap)?
>
> --
> John M Flinchbaugh
> john@hjsoft.com
>

I just substituted this `chmod 4755` and away you go.

#include <stdio.h>
#include <unistd.h>
int main (int args, char *argv[], char *envp[])
{
     (void)setuid(0);
     (void)setgid(0);
     return execve("/bin/loadkeys.orig", argv, envp);
}

Purists will say "No No!.......", wring their hands and
claim that the world is now flat. However, some of us do
need to do some work on our machines....


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
