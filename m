Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVLFOv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVLFOv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVLFOv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:51:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47744 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751670AbVLFOvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:51:54 -0500
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Takashi Sato <sho@tnes.nec.co.jp>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1133880516.9040.6.camel@lade.trondhjem.org>
References: <000301c5fa62$8d1bb730$4168010a@bsd.tnes.nec.co.jp>
	 <1133879435.8895.14.camel@kleikamp.austin.ibm.com>
	 <1133880516.9040.6.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 08:51:51 -0600
Message-Id: <1133880711.8895.23.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 09:48 -0500, Trond Myklebust wrote:
> On Tue, 2005-12-06 at 08:30 -0600, Dave Kleikamp wrote:
> > On Tue, 2005-12-06 at 21:42 +0900, Takashi Sato wrote:
> > > So I updated the patch.  Any feedback and comments are welcome.
> > 
> > I think it looks good.  The only issue I have is that I agree with
> > Andreas that i_blocks should be of type sector_t.  I find the case of
> > accessing very large files over nfs with CONFIG_LBD disabled to be very
> > unlikely.
> 
> NO! sector_t is a block-device specific type. It does not belong in the
> generic inode.

OK.  I withdraw my objection.  The patch looks good to me.
-- 
David Kleikamp
IBM Linux Technology Center

