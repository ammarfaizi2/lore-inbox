Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264895AbSJVTI5>; Tue, 22 Oct 2002 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264893AbSJVTH7>; Tue, 22 Oct 2002 15:07:59 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:57783
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S264892AbSJVTHv>; Tue, 22 Oct 2002 15:07:51 -0400
Message-ID: <3DB5A2E6.6000305@redhat.com>
Date: Tue, 22 Oct 2002 12:11:34 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave McCracken <dmccr@us.ibm.com>
CC: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
References: <Pine.LNX.4.44L.0210221514430.1648-100000@duckman.distro.conecti va> <145460000.1035311809@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44L.0210221514430.1648-100000@duckman.distro.conecti va>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave McCracken wrote:

>   3) The current large page implementation is only for applications
>      that want anonymous *non-pageable* shared memory.  Shared page
>      tables reduce resource usage for any shared area that's mapped
>      at a common address and is large enough to span entire pte pages.


Does this happen automatically (i.e., without modifying th emmap call)?

In any case, a system using prelinking will likely have all users of a
DSO mapping the DSO at the same address.  Will a system benefit in this
case?  If not directly, perhaps with some help from ld.so since we do
know when we expect the same is used everywhere.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9taLn2ijCOnn/RHQRAgJ6AJ9AzHCX3NrpZPpGUF9XIQYPdX2NPQCgw7BP
6fIfDzEvsxbGvVtoUX76aAw=
=LKpP
-----END PGP SIGNATURE-----

