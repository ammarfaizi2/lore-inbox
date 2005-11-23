Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbVKWXHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbVKWXHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbVKWXHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:07:31 -0500
Received: from mail.suse.de ([195.135.220.2]:34210 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030483AbVKWXH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:07:29 -0500
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Thu, 24 Nov 2005 10:07:13 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17284.63009.25299.139531@cse.unsw.edu.au>
Cc: "Lever, Charles" <Charles.Lever@netapp.com>,
       David Miller <davem@davemloft.net>, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
In-Reply-To: message from Adrian Bunk on Wednesday November 23
References: <044B81DE141D7443BCE91E8F44B3C1E2013327DF@exsvl02.hq.netapp.com>
	<20051123162528.GL3963@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 23, bunk@stusta.de wrote:
> On Wed, Nov 23, 2005 at 04:31:14AM -0800, Lever, Charles wrote:
> > so i don't remember why you are removing xdr_decode_string.  are we sure
> > that no-one will need this functionality in the future?  it is harmless
> > to remove today, but i wonder if someone is just going to add it back
> > sometime.
> 
> It's unused and you said:
>   the only harmless change i see below is removing xdr_decode_string().
> 

As 'xdr_decode_string' (sometimes) modifies the buffer that it is
decoding, I don't think it's usage should be encouraged.  If it is no
longer in use, then I fully support and encourage removing it.

NeilBrown
