Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264043AbRFERCo>; Tue, 5 Jun 2001 13:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264044AbRFERCZ>; Tue, 5 Jun 2001 13:02:25 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:39697 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S264043AbRFERCN>;
	Tue, 5 Jun 2001 13:02:13 -0400
Date: Tue, 5 Jun 2001 19:01:28 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Chris Wedgwood <cw@f00f.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
Message-ID: <20010605190128.A12204@pcep-jamie.cern.ch>
In-Reply-To: <15132.22933.859130.119059@pizda.ninka.net> <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net> <20010605155550.C22741@metastasis.f00f.org> <25587.991730769@redhat.com> <15132.40298.80954.434805@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15132.40298.80954.434805@pizda.ninka.net>; from davem@redhat.com on Tue, Jun 05, 2001 at 01:50:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Basically if you know the L2 cache size and the assosciativity you can
> do this as long as you can get a "2 * L2 cache size * assosciativity"
> piece of contiguous physical memory.  When you need this "simon says"
> flush, you basically read this physical memory span and this will
> guarentee that all dirty data has exited the L2 cache.

Whether this works depends on the cache line replacement policy.  It
will always work with LRU, for example, and probably everything else
that exists.  But it is not guaranteed, is it?

-- Jamie
