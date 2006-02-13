Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWBMRvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWBMRvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWBMRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:51:15 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:56068 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S932376AbWBMRvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:51:14 -0500
Date: Mon, 13 Feb 2006 18:51:12 +0100
From: iSteve <isteve@rulez.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060213185112.79da8ecc@silver>
In-Reply-To: <43F0AA61.1000607@cfl.rr.com>
References: <20060211103520.455746f6@silver>
	<m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
	<m3bqxd999u.fsf@telia.com>
	<20060211170813.3fb47a03@silver>
	<43EE446C.8010402@cfl.rr.com>
	<20060211211440.3b9a4bf9@silver>
	<43EE8B20.7000602@cfl.rr.com>
	<2006021 <20060213160024.5e01fa46@silver>
	<43F0AA61.1000607@cfl.rr.com>
X-Mailer: Sylpheed-Claws 2.0.0cvs42 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 10:48:49 -0500
Phillip Susi <psusi@cfl.rr.com> wrote:
> The media must be formatted first before you can write to it.  It looks 
> like you just tried to write to an unformatted disc.  Use cdrwtool -q 
> first to format it, then cdrwtool -f foo.img to write out your image. 
> 
> 
Tried. Tried also with setting -t 10 (the medium is 10x), without -p 1 (still
trying fixed packet size, same size). Out of four attempts, all failed.
 ----[snipet]----
# cdrwtool -d /dev/cdrw -q -p 1
using device /dev/cdrw
fixed packets
4690KB internal buffer
setting write speed to 12x
Settings for /dev/cdrw:
        Fixed packets, size 32
        Mode-2 disc

I'm going to do a quick setup of /dev/cdrw. The disc is going to be blanked and
formatted with one big track. All data on the device will be lost!! Press
CTRL-C to cancel now. ENTER to continue.

Initiating quick disc blank
Disc capacity is 295264 blocks (590528KB/576MB)
Formatting track
wait_cmd: Input/output error
Command failed: 04 17 00 00 00 00 00 00 00 00 00 00 - sense 05.64.00
format disc: Illegal seek
---[/snipet]----

DMESG:
cdrom: This disc doesn't have any tracks I recognize!

Please note that although I've been testing packet writing on 2.6.15.1, I'm
performing the initial burning on 2.6.12.1(+ squashfs), I apologize for not
mentioning this.

The udftools are from Debian, in version 1.0.0b3-11.
-- 
 -- iSteve
