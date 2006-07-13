Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWGMUPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWGMUPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWGMUPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:15:00 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:14549 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1030348AbWGMUO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:14:59 -0400
Message-ID: <44B6A9CA.8040808@cmu.edu>
Date: Thu, 13 Jul 2006 16:15:06 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060604)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org> <44B64F57.4060407@cmu.edu> <44B66740.2040706@goop.org>
In-Reply-To: <44B66740.2040706@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay I think I am getting closer, after doing some searching it turns
out that Hot pluggable CPU support is needed in the kernel to get
suspend working on a thinkpad x60.

Now, what I thought was fixed from reading threads, may not be

I am running 2.6.18-rc1-git7 and whenever I suspend, and then restore,
my screen remains black and I never get my shell back.  The machine
seems to be alive because I can ping it, however I cannot ssh into it.

Any more ideas?

Thanks!
George


Jeremy Fitzhardinge wrote:
> George Nychis wrote:
>> I am not seeing any problems at all, though I am not seeing anything
>> happen :)
>>
>> If I Fn+suspend... nothing happens ... if i Fn+hibernate ... nothing
>> happens
>>
>> What patches did you use?
> Sounds like your first step is to set up acpi.  What distro are you
> using?  What happens if you do "echo -n mem > /sys/power/state"?
> 
> The patches you need are to make the ahci disk interface resume
> properly.  There's a series of 6 patches from Forrest Zhao which he
> posted to the linux-ide list, and they apply cleanly to 2.6.18-rc1-mm1.
> 
>    J
> 
> 
