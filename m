Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143837AbRAHOo1>; Mon, 8 Jan 2001 09:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144089AbRAHOoR>; Mon, 8 Jan 2001 09:44:17 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:7628 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S143837AbRAHOoJ>; Mon, 8 Jan 2001 09:44:09 -0500
From: Christoph Rohland <cr@sap.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <200101081419.PAA26150@ns.caldera.de>
Organisation: SAP LinuxLab
Date: 08 Jan 2001 15:43:19 +0100
In-Reply-To: Christoph Hellwig's message of "Mon, 8 Jan 2001 15:19:25 +0100"
Message-ID: <qwwofxit88o.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, 8 Jan 2001, Christoph Hellwig wrote:
> I had a prototype tmpfs in -test10 (ro so) times.  It based on ramfs
> for all the metadata stuff and used the (old) shmfs code for
> swap-backed data.  The only real problem the code had, was that it
> needed a ->allocpage address_space method in place of
> page_cache_alloc() to directly swap-in pages in ->read.  IF anyone
> is interested I could forward port it to 2.4.0 and the new shmfs.

Be aware that there is nothing left from the old shm memory/swap
handling in 2.4.0. It is a copy of ramfs plus additions for swap and
resource limits

If you would be willing to add the read and write functions to the new
coding I would be very happy.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
