Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVAQL4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVAQL4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 06:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVAQL4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 06:56:30 -0500
Received: from sommereik.ii.uib.no ([129.177.16.236]:38814 "EHLO
	sommereik.ii.uib.no") by vger.kernel.org with ESMTP id S262777AbVAQL4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 06:56:25 -0500
Date: Mon, 17 Jan 2005 12:55:42 +0100
From: Jan-Frode Myklebust <Jan-Frode.Myklebust@bccs.uib.no>
To: Jakob Oestergaard <jakob@unthought.net>,
       Christoph Hellwig <hch@infradead.org>,
       David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20050117115542.GA28901@ii.uib.no>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>,
	David Greaves <david@dgreaves.com>, Jan Kasprzak <kas@fi.muni.cz>,
	linux-kernel@vger.kernel.org, kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net> <20041209215414.GA21503@infradead.org> <20041221184304.GF16913@fi.muni.cz> <20041222084158.GG347@unthought.net> <20041222182344.GB14586@infradead.org> <41E80C1F.3070905@dgreaves.com> <20050114182308.GE347@unthought.net> <20050116135112.GA24814@infradead.org> <20050117100746.GI347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117100746.GI347@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 11:07:46AM +0100, Jakob Oestergaard wrote:
> 
> Where should I begin?  ;)

Guess we've been struggeling with much of the same problems..

> -------
> Scenario 2: Mailservers:
>   Running XFS on mailqueue:

The 2.6.10-1.737_FC3 + 's/posix_lock_file/posix_lock_file_wait/' on
fs/nfs/file.c seems stable on our mailserver running XFS on
mail queue and spool (mbox). 4 days of uptime! 

> 
> =======
> Resolution to the storage server problem:
>  2.6.8.1 UP is stable (but oopses regularly after memory allocation
>  failures)

My XFS-fileserver ran 2.6.9-rc3 stable since october 25. Got lots of
"possible deadlock in kmem_alloc (mode:0xd0)" this weekend, so I
upgraded to plain 2.6.10. Seems OK so far. 

> 
> Hardware on all servers: IBM x335 and x345.

Mail servers: Dell 2650, IBM ServeRAID 6M, EXP400.
File servers: IBM x330, qla2300, infortrend eonstor.

All running Whitebox/centos RHEL clone.


  -jf
