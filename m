Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTAVMsI>; Wed, 22 Jan 2003 07:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTAVMsI>; Wed, 22 Jan 2003 07:48:08 -0500
Received: from gherkin.frus.com ([192.158.254.49]:35718 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267469AbTAVMsH>;
	Wed, 22 Jan 2003 07:48:07 -0500
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
In-Reply-To: <20030122083530.GA20780@suse.de> "from Jens Axboe at Jan 22, 2003
 09:35:30 am"
To: Jens Axboe <axboe@suse.de>
Date: Wed, 22 Jan 2003 06:57:14 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030122125714.EEE244EED@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Jan 22 2003, Joerg Schilling wrote:
> > I thought it's obvious: It is most likely a problem caused by the broken 
> > bit #defines in the Linux kernel for the SCSI status byte. I assume that
> > status should be 0x02 instead of 0x01. In addition, I would guess that
> 
> Sounds plausible. Patch attached. Anyone care to expand on _why_ these
> status bytes are shifted one bit?

Possibly related...  I was using SCSI tape to back up my 2.5.59 system
the other day.  A media error was encountered, but the application (cpio
in this case) never saw the error and kept on trying to write to the bad
tape.  Fortunately, I caught it after only 40 MB of associated syslog
entries had been made.

Thanks for the patch.  I can now go back to "unattended" backup mode
(except for having to change tapes periodically) :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
