Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUDHVTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDHVTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:19:09 -0400
Received: from p02m168.mxlogic.net ([216.173.230.168]:5281 "HELO
	p02m168.mxlogic.net") by vger.kernel.org with SMTP id S262424AbUDHVTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:19:07 -0400
From: Michael Driscoll <fenris@ulfheim.net>
Organization: FFW/CO
To: Martin Rode <martin.rode@zeroscale.com>
Subject: Re: cp fails in this symlink case, kernel 2.4.25, reiserfs + ext2
Date: Thu, 8 Apr 2004 15:17:48 -0600
User-Agent: KMail/1.6.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <1081359310.1212.537.camel@marge.pf-berlin.de> <1081365374.11164.24.camel@shaggy.austin.ibm.com> <1081410996.3770.1405.camel@marge.pf-berlin.de>
In-Reply-To: <1081410996.3770.1405.camel@marge.pf-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404081517.48243.fenris@ulfheim.net>
X-OriginalArrivalTime: 08 Apr 2004 21:19:01.0248 (UTC) FILETIME=[1CC6A800:01C41DAF]
X-MX-Spam: exempt
X-MX-MAIL-FROM: <fenris@ulfheim.net>
X-MX-SOURCE-IP: [63.78.248.11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 April 2004 01:56, Martin Rode wrote:
> On Wed, 2004-04-07 at 21:16, Dave Kleikamp wrote:
> > When you cd to alpha/beta, your current directory is really
> > .../tmp/bug/beta.  Your shell may remember that you got there through
> > the symlink in alpha, but cp will follow .., which is really bug.
>
> Bug in "cp", "bash" or in the kernel fs-layer?
>
> Martin

Call it a bug in POSIX, if anything ;)

Remember that '..' is a directory entry in the filesystem, not a construct of 
your shell.  Specifically, it is a pointer to the parent directory of the 
directory in which it is found.

Usually /a/b/../c is the same as a/c, but not if /a/b is a symlink to /d as in 
this case.

-- 
Michael Driscoll, fenris@ulfheim.net
"A noble spirit embiggens the smallest man" -- J. Springfield
