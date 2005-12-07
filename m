Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVLGPCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVLGPCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLGPCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:02:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:52697 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751120AbVLGPCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:02:01 -0500
Subject: RE: stat64 for over 2TB file returned invalid st_blocks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Takashi Sato <sho@tnes.nec.co.jp>,
       "'Andreas Dilger'" <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1133963528.27373.4.camel@lade.trondhjem.org>
References: <000001c5fb1d$0a27c8d0$4168010a@bsd.tnes.nec.co.jp>
	 <1133963528.27373.4.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 09:01:56 -0600
Message-Id: <1133967716.8910.5.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 08:52 -0500, Trond Myklebust wrote:
> On Wed, 2005-12-07 at 19:57 +0900, Takashi Sato wrote:
> 
> > On my previous mail, I said that CONFIG_LBD should not determine
> > whether large single files is enabled.  But after further
> > consideration, on such a small system that CONFIG_LBD is disabled,
> > using large filesystem over network seems to be very rare.
> > So I think that the type of i_blocks should be sector_t.
> 
> ???? Where do you get this misinformation from?

Without some kind of counter-example, I would tend to agree with
Takashi.  In what scenerio would someone build a kernel with CONFIG_LBD
disabled, yet would be needing to access files > 2TB across the network?

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

