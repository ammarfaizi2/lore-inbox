Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282328AbRKZTFe>; Mon, 26 Nov 2001 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282341AbRKZTDu>; Mon, 26 Nov 2001 14:03:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4833 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282262AbRKZTCp>;
	Mon, 26 Nov 2001 14:02:45 -0500
Date: Mon, 26 Nov 2001 22:00:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Momchil Velikov <velco@fadata.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <Pine.LNX.4.33.0111262133140.17709-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0111262153440.18592-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


there is a case where the binary tree has less cache footprint than the
hash - when big continuous areas of files are cached, *and* the access
patterns are linear. In this case the binary tree uses only the continuous
mem_map[] area for its data structures - while the hash uses the hash
table as well. (which is +12% or +25%, in the stock/buckets variant.)

	Ingo

