Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291308AbSBNKUs>; Thu, 14 Feb 2002 05:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291399AbSBNKUi>; Thu, 14 Feb 2002 05:20:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50193 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291308AbSBNKUZ>;
	Thu, 14 Feb 2002 05:20:25 -0500
Message-ID: <3C6B8F2D.F979A438@zip.com.au>
Date: Thu, 14 Feb 2002 02:19:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com> <3C69750E.8BA2C6AB@zip.com.au> <3C6A4449.3030703@evision-ventures.com> <3C6AB5D2.A7D665FE@zip.com.au> <3C6B8BA7.7030002@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> >The file_readahead setting works as expected and as desired.  Or at
> >least it did a few weeks ago.
> >
> The few weeks ago thing matters. It doesn't any longer.
> 

Please explain, in detail, why /proc/ide/hdX/settings:file_readhead
no longer controls the readhead for that device.  If this is
the case in thr current 2.4 kernel, or if it will become the
case if/when the IDE patches are merged then that needs fixing.


Look, I agree that the current readhead controls are junk, and
do not belong in the driver layer at all.   All I'm saying is
that we need per-device controls, for whatever scheme we end
up using for readhead in 2.5.   We really don't want to have
the same sized readhead for CDROMs, floppies and super-duper
RAID arrays.

-
