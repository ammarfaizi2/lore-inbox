Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264393AbUEIWNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbUEIWNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEIWNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:13:35 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33730 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264393AbUEIWNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:13:31 -0400
Date: Mon, 10 May 2004 00:08:59 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-ID: <20040510000859.A24234@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0405091058300.2106-100000@poirot.grange> <Pine.LNX.4.58.0405090832310.24865@ppc970.osdl.org> <20040509181122.GK5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040509181122.GK5414@waste.org>; from mpm@selenic.com on Sun, May 09, 2004 at 01:11:22PM -0500
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> :
[...]
> I suspect worst case is a large LAN fileserver with Samba shares and
> whatnot, I suspect there are a large number of "A picture of my cute
> puppy I took last summer.JPG" style filenames there. Anyone have stats
> for such an FS?

General purpose server (mail/smb/cvs/rpm repo) for 15 users: closer to
Andrew's results. "." and ".." do not appear in the results below.

   1:     0.30 % (    0.30 % cum -- 4263)
   2:     1.36 % (    1.65 % cum -- 19491)
   3:     2.64 % (    4.29 % cum -- 37905)
   4:     2.43 % (    6.72 % cum -- 34930)
   5:     2.00 % (    8.72 % cum -- 28816)
   6:     3.04 % (   11.75 % cum -- 43652)
   7:     4.80 % (   16.56 % cum -- 69065)
   8:     8.50 % (   25.06 % cum -- 122244)
   9:     4.96 % (   30.01 % cum -- 71310)
  10:    10.29 % (   40.30 % cum -- 147964)
  11:     6.29 % (   46.60 % cum -- 90527)
  12:     6.70 % (   53.30 % cum -- 96428)
  13:     4.02 % (   57.32 % cum -- 57766)
  14:     2.84 % (   60.16 % cum -- 40865)
  15:     2.36 % (   62.52 % cum -- 34000)
  16:     2.31 % (   64.84 % cum -- 33288)
  17:     3.58 % (   68.41 % cum -- 51421)
  18:     2.87 % (   71.28 % cum -- 41308)
  19:     2.10 % (   73.39 % cum -- 30263)
  20:     2.36 % (   75.75 % cum -- 33959)
  21:     2.78 % (   78.53 % cum -- 39951)
  22:     1.48 % (   80.01 % cum -- 21300)
  23:     2.01 % (   82.02 % cum -- 28975)
  24:     2.17 % (   84.19 % cum -- 31169)
  25:     1.32 % (   85.51 % cum -- 19047)
  26:     1.02 % (   86.54 % cum -- 14713)
  27:     0.85 % (   87.39 % cum -- 12282)
  28:     0.82 % (   88.21 % cum -- 11795)
  29:     0.75 % (   88.96 % cum -- 10783)
  30:     0.73 % (   89.69 % cum -- 10507)
  31:     0.59 % (   90.28 % cum -- 8454)
[...]
  57:     0.15 % (   99.06 % cum -- 2198)


Assuming one is only interested in the users's home directory:

   1:     0.37 % (    0.37 % cum -- 1638)
   2:     1.52 % (    1.90 % cum -- 6672)
   3:     3.40 % (    5.30 % cum -- 14907)
   4:     2.61 % (    7.91 % cum -- 11447)
   5:     1.71 % (    9.62 % cum -- 7498)
   6:     2.75 % (   12.37 % cum -- 12069)
   7:     4.83 % (   17.20 % cum -- 21186)
   8:    10.27 % (   27.48 % cum -- 45034)
   9:     4.79 % (   32.27 % cum -- 21005)
  10:     6.23 % (   38.50 % cum -- 27302)
  11:     6.51 % (   45.01 % cum -- 28551)
  12:     5.99 % (   51.00 % cum -- 26267)
  13:     4.13 % (   55.14 % cum -- 18107)
  14:     2.85 % (   57.98 % cum -- 12479)
  15:     2.26 % (   60.25 % cum -- 9921)
  16:     2.28 % (   62.53 % cum -- 10015)
  17:     2.88 % (   65.41 % cum -- 12604)
  18:     2.04 % (   67.45 % cum -- 8955)
  19:     2.26 % (   69.71 % cum -- 9903)
  20:     2.57 % (   72.28 % cum -- 11260)
  21:     2.02 % (   74.30 % cum -- 8874)
  22:     1.48 % (   75.78 % cum -- 6498)
  23:     2.08 % (   77.86 % cum -- 9109)
  24:     2.50 % (   80.36 % cum -- 10969)
  25:     1.35 % (   81.71 % cum -- 5921)
  26:     1.01 % (   82.72 % cum -- 4428)
  27:     0.85 % (   83.57 % cum -- 3705)
  28:     0.84 % (   84.41 % cum -- 3692)
  29:     0.80 % (   85.21 % cum -- 3489)
  30:     0.76 % (   85.97 % cum -- 3335)
  31:     0.63 % (   86.60 % cum -- 2757)
  32:     0.83 % (   87.43 % cum -- 3633)
  33:     0.49 % (   87.92 % cum -- 2151)
  34:     0.53 % (   88.45 % cum -- 2327)
  35:     0.45 % (   88.90 % cum -- 1959)
  36:     0.40 % (   89.29 % cum -- 1737)
  37:     0.47 % (   89.76 % cum -- 2068)
  38:     0.48 % (   90.24 % cum -- 2103)
[...]
  60:     0.13 % (   99.00 % cum -- 583)

--
Ueimor
