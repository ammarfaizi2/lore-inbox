Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbUJ0TTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUJ0TTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUJ0TRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:17:49 -0400
Received: from alog0319.analogic.com ([208.224.222.95]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262653AbUJ0TML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:12:11 -0400
Date: Wed, 27 Oct 2004 15:09:40 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving a syscall number
In-Reply-To: <417FED6E.3010007@comcast.net>
Message-ID: <Pine.LNX.4.61.0410271505110.4669@chaos.analogic.com>
References: <417FED6E.3010007@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> How would one go about having a specific syscall number reserved in
> entry.S?  I'm exploring doing a kill inside the kernel from a detection
> done in userspace, which would allow the executable header of the binary
> to indicate whether the task should be killed or not; if it works, the
> changes will likely not go into mainline, but will still require a
> non-changing syscall index (assuming I understood the syscall manpage
> properly).
>
> On a side note, if a syscall doesn't exist, how would that be detected
> in userspace?
> - --

Look at ld.so.preload for potential capabilities to control any
executable.

Also what's the problem with sending the task a signal when
the detection has been done?

If the usual capabilites are not sufficient, then make
a driver (module).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached and reviewed by John Ashcroft.
                  98.36% of all statistics are fiction.
