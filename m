Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTIMGu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 02:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbTIMGu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 02:50:59 -0400
Received: from users.linvision.com ([62.58.92.114]:59026 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262055AbTIMGu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 02:50:58 -0400
Date: Sat, 13 Sep 2003 08:50:48 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Kyle Rose <krose+linux-kernel@krose.org>, linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030913085048.A22707@bitwizard.nl>
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
> True, and O_LARGEFILE would have bit you at 2GB and not 4GB...  If you are
> doing output redirected from the shell, then it can't be a seek issue
> either.

Nah! Some programs just "try to seek" and if it works, will. 

dd if=/dev/zero count=200 | strace sox -t raw -r 44100 -s -w - -t wav - > /tmp/test

dd if=/dev/zero count=200 | sox -t raw -r 44100 -s -w - -t wav - | dd of=/tmp/test
sox: Length in output .wav header will be wrong since can't seek to fix it

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
