Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUAPPjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265352AbUAPPjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:39:03 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:34948 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265339AbUAPPjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:39:00 -0500
Date: Fri, 16 Jan 2004 15:46:46 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
To: Jonathan Kamens <jik@kamens.brookline.ma.us>, linux-kernel@vger.kernel.org
In-Reply-To: <16392.734.505550.6731@jik.kamens.brookline.ma.us>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
 <16389.63781.783923.930112@jik.kamens.brookline.ma.us>
 <16391.24288.194579.471295@jik.kamens.brookline.ma.us>
 <200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
 <16392.734.505550.6731@jik.kamens.brookline.ma.us>
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
> John Bradford writes:
>  > Quote from Jonathan Kamens <jik@kamens.brookline.ma.us>:
>  > > ... hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
>  > > ... hde: drive_cmd: error=0x04 { DriveStatusError }
>  > 
>  > The drive doesn't seem to understand the command it was sent.
> 
> I'm not sure what this means, but assuming that it's going to happen
> again at some point,

Maybe not - the most common cause I've seen for that message in the logs is trying to access S.M.A.R.T. information when S.M.A.R.T. is disabled.

I.E. the error should be reproducable with:

# smartctl -d /dev/hda
# smartctl -a /dev/hda

Are you sure you weren't trying to get S.M.A.R.T. info from the drive at the time the error was logged?

John.
