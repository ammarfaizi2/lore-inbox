Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262767AbSJGU0Y>; Mon, 7 Oct 2002 16:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262626AbSJGU0X>; Mon, 7 Oct 2002 16:26:23 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:48002 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S262766AbSJGUZe>; Mon, 7 Oct 2002 16:25:34 -0400
Date: Mon, 7 Oct 2002 21:31:55 +0100
From: "J.P. Morris" <jpm@it-he.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Radeon 7500 framebuffer garbled on 2.4.19
Message-Id: <20021007213155.4848f34d.jpm@it-he.org>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There appears to be a problem with the ATI fbdev on the Radeon 7500
under the 2.4.19 kernel.  I haven't yet tried older vintages.

The 8-bit colour modes work, but high and truecolour modes are garbled.
The effect is difficult to describe, but I'll try.  The colours are being
shifted oddly.  Greyscale images appear as a mixture of various colours with
little apparent logic.. largely dark purple but with sparkles of yellow etc.

When a full-colour image is displayed, it appears almost (but not quite) in
green-levels.  If the image is faded to black, the colours go wild.

Displaying the RGB scales proved quite interesting.. the three scales appear
at maximum intensity, but there are gaps.  For the main part, each alternate
level is missing giving a comb-tooth effect.  Some of the 'teeth' are at
half-intensity and some of the 'teeth' are not missing but haven't changed
intensity either.

The same basic pattern happens on 15,16 and 32 bpp modes.

SVGALIB doesn't suffer from this problem at all.  If I were more technically
inclined I'd go through the sources and compare the two.. but all I've found
so far is that I haven't a clue how a register-level display driver works. ;-(

Any ideas?  Comments?
