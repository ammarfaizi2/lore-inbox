Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUEWOda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUEWOda (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 10:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUEWOda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 10:33:30 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:57751 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262897AbUEWOd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 10:33:29 -0400
Subject: Re: Fw: IPsec/crypto kernel panic in 2.6.[456]
From: Christophe Saout <christophe@saout.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@redhat.com>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040520213743.GA9702@leto.cs.pocnet.net>
References: <20040520003739.624cc2d2.akpm@osdl.org>
	 <Xine.LNX.4.44.0405200409530.15731-100000@thoron.boston.redhat.com>
	 <20040520081049.4bfa7e3f.davem@redhat.com>
	 <20040520213743.GA9702@leto.cs.pocnet.net>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 May 2004 16:33:22 +0200
Message-Id: <1085322803.32532.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Small update: Tobias Ringström told me that the Oops goes away when he
applies the bugfix I sent Andrew. We're still trying to find out what
exactly was happening.

> The two problems I found:
> 
> After calling scatterwalk_copychunks walk_in might point to the next
> page which will break scatterwalk_samebuf (in this case src_p should
> point to tmp_src anyway and scatterwalk_samembuf returns 0).
> 
> scatterwalk_samebuf should also check for equal offsets inside the
> page (just bad for performance in some cases).


