Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUGXJ4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUGXJ4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 05:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUGXJ4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 05:56:32 -0400
Received: from users.linvision.com ([62.58.92.114]:35535 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264884AbUGXJ4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 05:56:31 -0400
Date: Sat, 24 Jul 2004 11:56:29 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: bert hubert <ahu@ds9a.nl>, Shesha Sreenivasamurthy <shesha@inostor.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>
Subject: Re: O_DIRECT
Message-ID: <20040724095629.GA9434@bitwizard.nl>
References: <40FD561D.1010404@inostor.com> <20040720184824.GA30090@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720184824.GA30090@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2004 at 08:48:24PM +0200, bert hubert wrote:
> On Tue, Jul 20, 2004 at 10:27:57AM -0700, Shesha Sreenivasamurthy wrote:
> > I am having trouble with O_DIRECT. Trying to read or write from a block 
> > device partition.
> > 
> > 1. Can O_DIRECT be used on a plain block device partition say 
> > "/dev/sda11" without having a filesystem on it.
> 
> As fas as I know, yes, but be aware that O_DIRECT requires page aligned
> addresses! (an integral of 4096 on most systems).

Agreed, and I can tell you it works with raw disk devices. The code
we use is: 

  p = malloc (blocksize + PAGE_SIZE);
  buf = (void *) ((  ((long)p) + PAGE_SIZE -1 ) & ~(PAGE_SIZE-1));

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
