Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262065AbREYX7u>; Fri, 25 May 2001 19:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262068AbREYX7k>; Fri, 25 May 2001 19:59:40 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28869 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262065AbREYX71>;
	Fri, 25 May 2001 19:59:27 -0400
Message-ID: <3B0EF1DC.CD0DF4D7@mandrakesoft.com>
Date: Fri, 25 May 2001 19:59:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-ntfs-announce@lists.sourceforge.net
Subject: Re: ANN: NTFS new release available (1.1.15)
In-Reply-To: <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> NTFS 1.1.15 - ChangeLog
> =======================
> - Support for more than 128kiB sized runlists (using vmalloc_32() instead
> of kmalloc()).

If you are running into kmalloc size limit, please consider some
alternative method of allocation.
Can you map it into the page cache, as Al Viro has done in recent
patches?
Can you break your allocation into an array of pages, obtained via
get_free_page?
If runlists are on-disk structures, can you look at bh->b_data instead
of keeping them in memory?

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
