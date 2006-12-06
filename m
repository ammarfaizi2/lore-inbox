Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935226AbWLFPbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935226AbWLFPbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935390AbWLFPbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:31:44 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:38462 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935226AbWLFPbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:31:43 -0500
In-Reply-To: <m13b7t7viq.fsf@ebiederm.dsl.xmission.com>
References: <5986589C150B2F49A46483AC44C7BCA490728A@ssvlexmb2.amd.com> <m13b7t7viq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <124CB3B2-C140-4B0A-96D0-21457B3DC086@kernel.crashing.org>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>, Peter Stuge <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       Stefan Reinauer <stepan@coresystems.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       David Brownell <david-b@pacbell.net>, linuxbios@linuxbios.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Date: Wed, 6 Dec 2006 16:31:36 +0100
To: ebiederm@xmission.com (Eric W. Biederman)
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What do you mean by
>> +	for (reps = 0; reps >= 0; reps++) {
>> ?
>
> If you will not reps is negative.  Roughly it is a loop
> that will timeout eventually if a usb debug cable is not present.

> So since I didn't know how many loop iterations made sense I allowed
> it to loop for 2^31 times or until reps goes negative.

This doesn't work however.  Signed overflow in C is undefined,
and GCC actually optimises accordingly (unless -fwrapv is used).


Segher

