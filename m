Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbTIMGvy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 02:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTIMGvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 02:51:54 -0400
Received: from users.linvision.com ([62.58.92.114]:61586 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262060AbTIMGvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 02:51:52 -0400
Date: Sat, 13 Sep 2003 08:51:50 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Kyle Rose <krose+linux-kernel@krose.org>, linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030913085150.B22707@bitwizard.nl>
References: <87r82noyr9.fsf@nausicaa.krose.org> <20030911144732.S18851@schatzie.adilger.int> <87n0dboxhg.fsf@nausicaa.krose.org> <20030911150017.T18851@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911150017.T18851@schatzie.adilger.int>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 03:00:17PM -0600, Andreas Dilger wrote:
> On Sep 11, 2003  16:56 -0400, Kyle Rose wrote:
> > > I would guess that mkisofs isn't opening the file with O_LARGEFILE.
> > > It probably only expected to write 600MB output files.  Purely a
> > > guess though.
> > 
> > Thanks for the suggestion, but it is, in fact, opening with
> > O_LARGEFILE:
> > 
> > open("/mnt/angband/krose/tmp/862839.img", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
> 
> True, and O_LARGEFILE would have bit you at 2GB and not 4GB...  If you are
> doing output redirected from the shell, then it can't be a seek issue
> either.

... but mkisofs will NOT be seeking, as we commonly burn CDs while
mkisofs is providing the data through a pipe. 

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
