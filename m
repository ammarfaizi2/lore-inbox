Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUBRCsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUBRCsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:48:53 -0500
Received: from hera.kernel.org ([63.209.29.2]:1928 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261973AbUBRCsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:48:51 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Unicode normalization (userspace issue, but what the heck)
Date: Wed, 18 Feb 2004 02:48:26 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0ujpq$3r5$1@terminus.zytor.com>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <pan.2004.02.15.03.33.48.209951@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1077072506 3942 63.209.29.3 (18 Feb 2004 02:48:26 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 18 Feb 2004 02:48:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <pan.2004.02.15.03.33.48.209951@smurf.noris.de>
By author:    Matthias Urlichs <smurf@smurf.noris.de>
In newsgroup: linux.dev.kernel
> 
> Not locale, but normalization problems and identical-glyph problems.
> 
> Which is actually worse, because you don't have filenames which look
> like crap -- instead you have filenames which look perfectly sane, but
> they still do not work. Example: is an á one character, or is it an a
> followed by a composing ´?
> 
> Mac OSX, just as an example, only uses decomposed filenames. I don't know
> the current situation, but 10.2 has major problems when you try to access
> files with composite characters in their name (across NFS for instance).
> 
> I wonder if Linux, i.e. Linus ;-) should decree one single standard
> normalization. (I am NOT saying that enforcing this would be the kernel's
> job!)
> 

I believe that for most applications, normalization form C should be
used.

However, I suspect there are some applications for which this would
not apply.

	-hpa
