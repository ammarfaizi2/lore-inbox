Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284079AbRLKWEr>; Tue, 11 Dec 2001 17:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284118AbRLKWEh>; Tue, 11 Dec 2001 17:04:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24453 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284079AbRLKWEd>;
	Tue, 11 Dec 2001 17:04:33 -0500
Date: Tue, 11 Dec 2001 14:04:09 -0800 (PST)
Message-Id: <20011211.140409.21593464.davem@redhat.com>
To: anton@samba.org
Cc: axboe@suse.de, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011211212802.GA30520@krispykreme>
In-Reply-To: <20011211164744.GC13498@suse.de>
	<20011211165426.GD13498@suse.de>
	<20011211212802.GA30520@krispykreme>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Wed, 12 Dec 2001 08:28:02 +1100
   
   This seems to be happening because we now allow sg merging through
   the BIOVEC_MERGEABLE macro. On ppc64 (and sparc64) we can coalesce two
   sg entries if the first one ends on a page boundary and the next one
   starts on a page boundary because we have an IO MMU. (I know that you
   know this, Im just explaining it for those who dont :)

In that case you perhaps should be defining DMA_CHUNK_SIZE in
asm/dma.h :-)
