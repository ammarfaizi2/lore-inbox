Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVAQNs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVAQNs3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVAQNs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:48:29 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:65462 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S262802AbVAQNsF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:48:05 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: Jan-Frode Myklebust <Jan-Frode.Myklebust@bccs.uib.no>
Subject: Re: XFS: inode with st_mode == 0
Date: Mon, 17 Jan 2005 14:48:40 +0100
User-Agent: KMail/1.7.2
Cc: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20050117100746.GI347@unthought.net> <20050117115542.GA28901@ii.uib.no>
In-Reply-To: <20050117115542.GA28901@ii.uib.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501171448.41905.as@cohaesio.com>
X-OriginalArrivalTime: 17 Jan 2005 13:48:04.0931 (UTC) FILETIME=[2B455130:01C4FC9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 17 January 2005 12:55, Jan-Frode Myklebust wrote:
>
> Guess we've been struggeling with much of the same problems..

Seems like it. :)

> > -------
> > Scenario 2: Mailservers:
> >   Running XFS on mailqueue:
>
> The 2.6.10-1.737_FC3 + 's/posix_lock_file/posix_lock_file_wait/' on
> fs/nfs/file.c seems stable on our mailserver running XFS on
> mail queue and spool (mbox). 4 days of uptime!

Yes - We had those errors to:

"Kernel panic - not syncing: Attempting to free lock with active block list"

- on 2.6.10 on the webservers, which was fixed with that particular patch. But 
this is a different error as our mailservers dont't act as NFS clients. All 
use local XFS.

Sad thing is that the mailservers crashes every 10-20 hours on 2.6.x, but I'm 
not able to reproduce it in a test environment, and at time of original post 
to LKML noone was able to do anything about it without a reproduceable 
testcase. :(

> > =======
> > Resolution to the storage server problem:
> >  2.6.8.1 UP is stable (but oopses regularly after memory allocation
> >  failures)
>
> My XFS-fileserver ran 2.6.9-rc3 stable since october 25. Got lots of
> "possible deadlock in kmem_alloc (mode:0xd0)" this weekend, so I
> upgraded to plain 2.6.10. Seems OK so far.
>

OK, as far as i remember, we had the same messages in the kernel log when 
running with SMP.

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
