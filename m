Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSFECZk>; Tue, 4 Jun 2002 22:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317492AbSFECZk>; Tue, 4 Jun 2002 22:25:40 -0400
Received: from mail.reutershealth.com ([204.243.9.36]:45303 "EHLO
	mail.reutershealth.com") by vger.kernel.org with ESMTP
	id <S317489AbSFECZj>; Tue, 4 Jun 2002 22:25:39 -0400
Message-Id: <200206050224.WAA00121@mail.reutershealth.com>
From: John Cowan <jcowan@reutershealth.com>
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, release 3.0 is available
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 4 Jun 2002 22:25:20 -0400 (EDT)
Cc: Alexander.Riesen@synopsys.com, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <17931.1023231335@ocs3.intra.ocs.com.au> from "Keith Owens" at Jun 05, 2002 08:55:35 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens scripsit:

> In order to do separate source and object correctly, kbuild 2.5
> enforces the rule that #include "" comes from the local directory,
> #include <> comes from the include path.  include/linux/zlib.h
> incorrectly does #include "zconf.h" instead of #include <linux/zconf.h>,
> breaking the rules.

This is not the standard gcc behavior, however; quoted-includes
can come from the include path, although the current directory
is searched first.  The purpose of <>-includes is to suppress
searching the current directory.

-- 
John Cowan <jcowan@reutershealth.com>     http://www.reutershealth.com
I amar prestar aen, han mathon ne nen,    http://www.ccil.org/~cowan
han mathon ne chae, a han noston ne 'wilith.  --Galadriel, _LOTR:FOTR_
