Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUJKMG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUJKMG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268681AbUJKMG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:06:26 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:25747 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268851AbUJKMEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:04:47 -0400
In-Reply-To: <200410111111.i9BBBolv025895@hacksaw.org>
References: <200410111111.i9BBBolv025895@hacksaw.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <AE30E0FE-1B7D-11D9-96AD-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: udev: what's up with old /dev ? 
Date: Mon, 11 Oct 2004 14:04:19 +0200
To: Hacksaw <hacksaw@hacksaw.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 11, 2004, at 13:11, Hacksaw wrote:

>> FC3t2 boots from an "initrd" image that, among other things, mounts a
>> tmpfs over "/dev" and creates "console", "null", "pts" and then
>> proceeds to load "init".
>
> Is that considered good? I like RedHat, but they are well known for 
> doing
> things of dubious taste.
>
> But I just dislike the whole "stopped dead because of the state of the 
> disk"
> thing. I mean, sure, if there large amounts of stuff just missing, it 
> might be
> hard to get anything done, but it sure would be nice if the kernel 
> would try
> really hard to get to a shell so I can figure out what the problem is.
>
> If the initrd gets corrupted, are we just hosed?

In some way, the answer is yes... I think the best is having a real, 
on-disk, full "/dev" hierarchy in case the INITRD gets lost or 
corrupted, which will still allow booting. Now, the INITRD can mount 
tmpfs over "/dev" and use udev to create needed device nodes.

