Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268285AbRHJN4H>; Fri, 10 Aug 2001 09:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268182AbRHJNz5>; Fri, 10 Aug 2001 09:55:57 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:9095 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268149AbRHJNzv>; Fri, 10 Aug 2001 09:55:51 -0400
Date: Fri, 10 Aug 2001 14:56:02 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writes to mounted devices containing file-systems.
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
Message-ID: <Pine.SOL.3.96.1010810143222.9790A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Richard B. Johnson wrote:
> Is it possible that Linux could decline to write to a device that
> contains mounted file-systems? OTW, don't allow raw writes to
> devices or partitions if they are mounted; writes could only
> be through the file-systems themselves.

Policy is not something we want in the kernel. Detection and prevention of
writing happens in programs trying to write. E.g. mkntfs will detect that
a partition you are trying to format is mounted and refuse to write to it;
but it provides a "force" switch if you really wanted to do it... I can
think of situations where I really want to write to a mounted fs
(admittedly they not standard use but still I might want to do it).

Anyway, the kernel could never provide you with ultimate security without
sacrificing all functionality. Once they get in, they will get root and
once they have root you have lost, you need to have a system without a
root user and with nobody having capabilities to do things like load
modules, etc... There are so many local exploits that you would lose
for sure. If the attacker cannot write to raw device, he will unmount and
then write to it or he will load a module to send commands to your HD at
ATAPI or SCSI level and kill your hd that way...

[snip destruction of your data]

Why don't you increase security on your machine? - For example do you
really need to run sendmail listenting on port 25? Systems seem to run
quite happily without sendmail listening. All internal use happens
through direct invokation of sendmail binary but YMMV. At least does it
have to listen to anything other than 127.0.0.1?

[snip a lot of horror story about company]

As others have suggested already, it sounds like you want to start looking
for alternative employment...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

