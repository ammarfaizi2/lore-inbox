Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271950AbRIIMdP>; Sun, 9 Sep 2001 08:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271951AbRIIMdF>; Sun, 9 Sep 2001 08:33:05 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:22675 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S271950AbRIIMc4>;
	Sun, 9 Sep 2001 08:32:56 -0400
Message-Id: <5.1.0.14.2.20010909133049.03bc1d50@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 09 Sep 2001 13:33:05 +0100
To: Aaron Lehmann <aaronl@vitelus.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux 2.4.10-pre6, NTFS build break
Cc: John Kacur <jkacur@home.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010908233859.A4284@vitelus.com>
In-Reply-To: <3B9AFE23.ACB3023E@home.com>
 <Pine.LNX.4.33.0109081949510.1097-100000@penguin.transmeta.com>
 <3B9AFE23.ACB3023E@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:38 09/09/2001, Aaron Lehmann wrote:
>On Sun, Sep 09, 2001 at 01:29:07AM -0400, John Kacur wrote:
> > Perhaps this can just be turned into
> > static inline ntfs_debug(mask, fmt, ...)      do {} while(0)
>
>You mean static inline ntfs_debug(mask,fmt,...) { }

Actually:

static inline ntfs_debug(int mask, const char *fmt, ...) { }

>but it should probably also work as
>
>#define ntfs_debug(mask, fmt...) do {} while(0)

Indeed. This is what I intended to write but gcc-2.96 obviously forgave me 
the typo... as it both compiles and works fine here.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

