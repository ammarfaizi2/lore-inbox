Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTDFVuc (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTDFVub (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:50:31 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:36757 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263117AbTDFVua (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:50:30 -0400
Date: Mon, 07 Apr 2003 09:58:57 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: Fixes for ide-disk.c
In-reply-to: <1049662835.1600.31.camel@dhcp22.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049666337.9837.11.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
 <1049570711.3320.2.camel@laptop-linux.cunninghams>
 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
 <1049663520.8403.26.camel@laptop-linux.cunninghams>
 <1049662835.1600.31.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 09:00, Alan Cox wrote:
> There are multiple "blocked" fields to deal with. drive->blocked
> indicates we can't feed it commands because it is blocked due to
> power management.
> 
> idedisk_suspend sets the drive->blocked field so that we panic if
> anything is sent to the disk after we turned it off (since it
> would be a corrupter).
> 
> idedisk_resume is called on the resume path and marks the drive
> as safe to use.
> 
> So if you hit that bug, you did I/O after shutting the drive down,
> which is not allowed.

Okay. So the right behaviour is to ignore multiple idedisk_suspend calls
and ignore multiple idedisk_resume calls?

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

