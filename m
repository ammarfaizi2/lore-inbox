Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRETQ6c>; Sun, 20 May 2001 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262086AbRETQ6X>; Sun, 20 May 2001 12:58:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:13300 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262084AbRETQ6L>; Sun, 20 May 2001 12:58:11 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010520031807.G23718@parcelfarce.linux.theplanet.co.uk> 
In-Reply-To: <20010520031807.G23718@parcelfarce.linux.theplanet.co.uk>  <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu> <E1517Jf-0008PV-00@the-village.bc.nu> <200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca> 
To: Matthew Wilcox <matthew@wil.cx>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 17:57:05 +0100
Message-ID: <17695.990377825@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matthew@wil.cx said:
>  I can tell you haven't had to write any 32-bit ioctl emulation code
> for a 64-bit kernel recently.

If that had been done right the first time, you wouldn't have had to either.
For that matter, it's often the case that if the ioctl had been done right
the first time, nobody would have had to fix it up for any architecture.

I made the mistake of using machine-specific types in some ioctls, but 
fixed them as soon as I realised some poor sod was going to have to write 
and maintain the ugly conversion code.

For pointers, sometimes it's justified. Often however, as in my case, it
was just stupidity on the part of the original coder and should be fixed.
Although I suppose I have the advantage that I don't have to worry too much
about binary compatibility for the things I changed.

--
dwmw2


