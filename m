Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271919AbRIDJbL>; Tue, 4 Sep 2001 05:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271921AbRIDJbC>; Tue, 4 Sep 2001 05:31:02 -0400
Received: from d179.dhcp212-198-121.noos.fr ([212.198.121.179]:19473 "EHLO
	microsoft.com") by vger.kernel.org with ESMTP id <S271919AbRIDJar>;
	Tue, 4 Sep 2001 05:30:47 -0400
Subject: Re: [RFD] readonly/read-write semantics
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0109040001000.26423-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109040001000.26423-100000@weyl.math.psu.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.22.00.33 (Preview Release)
Date: 04 Sep 2001 11:26:16 +0200
Message-Id: <999595577.11178.3.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, 2001-09-04 at 06:09, Alexander Viro wrote:

> Read-only is more complex - in addition to mount side ("does anyone want
> it to be r/w") there is a filesystem side ("does fs agree to be r/w")...

How about, say, a reiserfs mounted r/o on a shared partition (loopback
over nfs) ? If it contains errors, maybe 2 "clients" will attempt to
rollback at the same time. Is the solution to never mount, even r/o,
remote journalling fs ?

	Xav
