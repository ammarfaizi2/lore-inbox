Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288804AbSAIFDl>; Wed, 9 Jan 2002 00:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288805AbSAIFDb>; Wed, 9 Jan 2002 00:03:31 -0500
Received: from gear.torque.net ([204.138.244.1]:19473 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S288804AbSAIFDS>;
	Wed, 9 Jan 2002 00:03:18 -0500
Message-ID: <3C3BCEB9.B14D20FD@torque.net>
Date: Wed, 09 Jan 2002 00:01:46 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.2-pre9 scsi cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com>

> The attached patch does the following.
> 
> 1. Clean up some ifdef confusion in do_mount
> 
> 2. Clean up the scsi code to make ppa.c work.
> 
> 3. Clean up some unneccessary unneeded globals from scsi code.
> 
> 4. Make a bit more sure, that the minor() and friends end up in
> unsigned int's.

<snip/>

Martin,
Please don't post a omnibus SCSI subsystem patch like this.

Most of the code you are changing is actively maintained.
For example:
  - scsi mid-level + sr [Jens Axboe]
  - ppa [Tim Waugh]
  - sg  [me]

Some of us have grown attached to the way 'cat /proc/scsi/scsi'
looks. More importantly, many distributions have scripts that
parse it. GOTO Masanori's <gotom@debian.or.jp> suggestion of
of an exported scsi_device_types() seems a better option.
Also there are 32 SCSI device types (0 to 31) and perhaps
the "unknown"s and those that are missing could be replaced
by scsi_dev_<n> .

Also there is an appropriate newsgroup for this sort of
proposal and it is called: linux-scsi@vger.kernel.org

Doug Gilbert
