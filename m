Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291297AbSAaUzm>; Thu, 31 Jan 2002 15:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291294AbSAaUzd>; Thu, 31 Jan 2002 15:55:33 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:35556 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291290AbSAaUzP>; Thu, 31 Jan 2002 15:55:15 -0500
Date: Thu, 31 Jan 2002 20:55:07 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Eli Carter <eli.carter@inet.com>
cc: Richard Gooch <rgooch@atnf.csiro.au>, linux-kernel@vger.kernel.org
Subject: Re: vfs.txt and i_ino
In-Reply-To: <3C59A904.1ABC93BF@inet.com>
Message-ID: <Pine.SOL.3.96.1020131205057.15330A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, Eli Carter wrote:
> It appears that struct inode i_ino has a special value of 0.  I don't
> see a mention of that in vfs.txt, and I haven't found anything obvious
> in the fs code... Would it be possible to add some documentation of
> that, along with an explaination of what i_ino==0 is supposed to
> indicate?  (Bad/invalid inode?)

i_ino = 0 is perfectly valid and is in fact one of the system files in
NTFS. And accessing inode 0 from user space works fine, too. The only
thing which is odd is that a simple "ls" (or "ls -l") doesn't show the
file with i_ino=0, while an explicit ls a-la "ls \$MFT" (or "ls -l \$MFT") 
does show the file. I believe this to be purely a userspace problem but
when I looked at the /bin/ls source I got scared and ran away... A short
investigation into /bin/ls source didn't make anything obvious appear but
I do think it is /bin/ls at fault and not the kernel...

So I guess my point is that i_ino=0 is not special as far as the kernel is
concerned.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

