Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135830AbRECRvo>; Thu, 3 May 2001 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135851AbRECRve>; Thu, 3 May 2001 13:51:34 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20430 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135830AbRECRvT>;
	Thu, 3 May 2001 13:51:19 -0400
Message-ID: <3AF19A8E.5E306079@mandrakesoft.com>
Date: Thu, 03 May 2001 13:51:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: afei@jhu.edu
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: The 2.4 /proc module change
In-Reply-To: <Pine.GSO.4.05.10105031325030.13150-100000@aa.eps.jhu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

afei@jhu.edu wrote:
> 
> In the old 2.x kernels, a /proc module registers itself through
> proc_register(&proc_root, &proc_self) and unregister itself through
> proc_unregister(&proc_root, inode)

Use create_proc[_read]_entry and remove_proc_entry instead... 
create_proc_read_entry was added in 2.3, but {create,remove}_proc_entry
should work in 2.2 also, iirc.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
