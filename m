Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291317AbSAaVSd>; Thu, 31 Jan 2002 16:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291319AbSAaVSX>; Thu, 31 Jan 2002 16:18:23 -0500
Received: from zeke.inet.com ([199.171.211.198]:30874 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S291317AbSAaVSN>;
	Thu, 31 Jan 2002 16:18:13 -0500
Message-ID: <3C59B487.64B7631A@inet.com>
Date: Thu, 31 Jan 2002 15:17:59 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
CC: Richard Gooch <rgooch@atnf.csiro.au>, linux-kernel@vger.kernel.org
Subject: Re: vfs.txt and i_ino
In-Reply-To: <Pine.SOL.3.96.1020131205057.15330A-100000@virgo.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> On Thu, 31 Jan 2002, Eli Carter wrote:
> > It appears that struct inode i_ino has a special value of 0.  I don't
> > see a mention of that in vfs.txt, and I haven't found anything obvious
> > in the fs code... Would it be possible to add some documentation of
> > that, along with an explaination of what i_ino==0 is supposed to
> > indicate?  (Bad/invalid inode?)
> 
> i_ino = 0 is perfectly valid and is in fact one of the system files in
> NTFS. And accessing inode 0 from user space works fine, too. The only
> thing which is odd is that a simple "ls" (or "ls -l") doesn't show the
> file with i_ino=0, while an explicit ls a-la "ls \$MFT" (or "ls -l \$MFT")
> does show the file. I believe this to be purely a userspace problem but
> when I looked at the /bin/ls source I got scared and ran away... A short
> investigation into /bin/ls source didn't make anything obvious appear but
> I do think it is /bin/ls at fault and not the kernel...
> 
> So I guess my point is that i_ino=0 is not special as far as the kernel is
> concerned.

Hmm... 'ls -al' doesn't show the file for me.  I was using i_ino=0 for
the root inode, and found that 'ls -al' did not display '.' or '..'.  It
very well may be a user-space error... do you know who I should ask
about it?

TIA,

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
