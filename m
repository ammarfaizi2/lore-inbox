Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRA3Iku>; Tue, 30 Jan 2001 03:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129299AbRA3Ikk>; Tue, 30 Jan 2001 03:40:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7297 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129101AbRA3Ika>;
	Tue, 30 Jan 2001 03:40:30 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14966.32188.408789.239466@pizda.ninka.net>
Date: Tue, 30 Jan 2001 00:39:24 -0800 (PST)
To: David Howells <dhowells@redhat.com>
Cc: Rasmus Andersen <rasmus@jaquet.dk>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11) 
In-Reply-To: <13240.980842736@warthog.cambridge.redhat.com>
In-Reply-To: <rasmus@jaquet.dk>
	<20010129224311.H603@jaquet.dk>
	<13240.980842736@warthog.cambridge.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Howells writes:
 > Would it not be better to use some sort of atomic add/subtract/clear operation
 > rather than a spinlock? (Which would also give you fewer atomic memory access
 > cycles).

Please see older threads about this, it has been discussed to death
already (hint: sizeof(atomic_t), sizeof(unsigned long)).

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
