Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUHCR2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUHCR2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 13:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUHCR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 13:28:33 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:21393 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S266745AbUHCR2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 13:28:31 -0400
Message-ID: <410FCB3A.9000401@tlinx.org>
Date: Tue, 03 Aug 2004 10:28:26 -0700
From: L A Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de> <64bf.410f9d6f.62af@altium.nl> <410FA44F.1020804@bio.ifi.lmu.de>
In-Reply-To: <410FA44F.1020804@bio.ifi.lmu.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe I'm missing something, but in the 2.6 series, wasn't the ability
to mount subdirectories with different options, also, added?  Would
it be possible to export and mount /dev with rw options to a specific
client?

Or, more radical, if the roots of the clients end up being mounted RW
eventually anyway, why not specify 'rw' in the lilo option?  It's not
like it is a local filesystem that may be corrupt where one should
boot from it RO until it is checked...

But I've never tried either approach, so it's really only an 
idea/possibility.

Hope something works....the booting with a local initrd seems like it
would be a pain...

good luck,
Linda

Frank Steiner wrote:

> Dick Streefland wrote:
>
>> Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote:
>> | Or is there any other way to get an initial console or
>> | output any messages from an init script if one boots via nfsroot
>> | and  / (and thus, /dev) is only exported read-only from the
>> | server?
>>
>> You can boot with a ramdisk as root, initialized with an initrd, and
>> then perform all NFS mounts manually in the init script. You can use
>> pivot_root to switch to an NFS root to get rid of the ramdisk.
>
>
> I'm hoping for an easier solution, because it's a lot of work just
> to get the console messages onto the screen. But maybe I have to go
> through this :-)
>
>
>
