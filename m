Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311244AbSC0JRE>; Wed, 27 Mar 2002 04:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312982AbSC0JQy>; Wed, 27 Mar 2002 04:16:54 -0500
Received: from bzq-128-3.bezeqint.net ([212.179.127.3]:42252 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S311244AbSC0JQh>;
	Wed, 27 Mar 2002 04:16:37 -0500
Date: Wed, 27 Mar 2002 11:17:39 +0200 (IST)
From: Matan <matan@svgalib.org>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Dave Jones <davej@suse.de>, Boris Bezlaj <boris@kista.gajba.net>,
        kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mdacon.c minor cleanups
In-Reply-To: <Pine.LNX.4.44.0203250951520.14794-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.21_heb2.09.0203262345140.3857-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Zwane Mwaikambo wrote:

> The mdacon probe code doesn't seem to work well, if i have it compiled in
> it *always* detects an MDA card, even if there isn't one actually in the
> box. I can provide the dmesg if anyone's interested.

The mdacon.c in 2.4.18 does not actually test for an MDA card, it only
test for ram where the MDA vram is. The problem is that almost any vga
card maps ram to that address.
There is a test, but it is somewhat wrong (it changes registers, but
does not save and restore the original values) and is commented out. If
you fix this and uncomment the test, it works in some cases (this was
discussed under the subject "MDA video detection request" on July 2000).


-- 
Matan Ziv-Av.                         matan@svgalib.org





