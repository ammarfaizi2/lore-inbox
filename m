Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVF2RwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVF2RwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF2RwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:52:15 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:16261 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262344AbVF2Rv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:51:59 -0400
Subject: Re: [02/07] [SCSI] qla2xxx: Pull-down scsi-host-addition to follow
	board initialization.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org,
       tytso@mit.edu, zwane@arm.linux.org.uk, jmforbes@linuxtx.org,
       rdunlap@xenotime.net, Linus Torvalds <torvalds@osdl.org>,
       chuckw@quantumlinux.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       andrew.vasquez@qlogic.com
In-Reply-To: <20050629100835.60dc42f8.khali@linux-fr.org>
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
	 <20050627225349.GK9046@shell0.pdx.osdl.net>
	 <20050628235148.4512d046.khali@linux-fr.org>
	 <20050628152037.690c3840.akpm@osdl.org>
	 <20050629100835.60dc42f8.khali@linux-fr.org>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:36:14 -0500
Message-Id: <1120062974.4824.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 10:08 +0200, Jean Delvare wrote:
> this patch breaks 4 (it is bigger than 100
> lines, if fixes more than one thing, including one that doesn't bother
> people as far as I can see, and it has trivial fixes in it.) So I don't
> think I am actually splitting hair as you seemed to suggest. I know some
> of these rules were slightly reworded afterwards, but still.

Not according to my diffstat, it doesn't:

qla_os.c |   55 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

The basic rationale for this one is that it corrects a late spotted
error in a driver update that went into 2.6.12.  Without this, the
qla2xxx driver crashes for numerous people on loading (linux-scsi has
all the bug reports).  Since it's clearly a bug fix correcting a major
feature failure, that qualifies it for -stable.  The two code cleanup
corrections look trivial and not worth delaying this over (also, as has
been pointed out, they make it identical with the patch applied upstream
of 2.6.12, so there wouldn't be any merge issues).

James


