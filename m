Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUCXUCP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUCXUCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:02:14 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:64115 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S263811AbUCXUBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:01:23 -0500
Date: Wed, 24 Mar 2004 14:01:21 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: ameer armaly <ameer@charter.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing files in bk trees?
Message-ID: <20040324200121.GF20793@hexapodia.org>
References: <Pine.LNX.4.58.0403232140160.7713@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403232140160.7713@debian>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 09:41:46PM -0500, ameer armaly wrote:
> I got the latest kernel tree from linux.bkbits.net, and I try to make
> config, and it complains about a missing zconf.tab.h.  However, it has
> decrypted the other sccs files, but for some oodd reason it can't find
> this particular one.  Suggestions would be appriciated.

The build fails on this file because the kernel makefiles don't have
complete dependency information.  Make is smart enough to automatically
check out foo.c and foo.h if you say

foo.o: foo.c foo.h
	$(CC) -c foo.c -o foo.o

but in the absence of that information, make cannot deduce it.

The work-around is to simply check out everything before running make:
% bk -Ur get -S

-andy
