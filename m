Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTILClM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTILClM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:41:12 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:33964 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261203AbTILClK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:41:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Adrian Bunk <bunk@fs.tum.de>
Date: Fri, 12 Sep 2003 12:40:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16225.12839.319206.649577@notabene.cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] fix nfs4xdr.c compile warning
In-Reply-To: message from Adrian Bunk on Tuesday September 9
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org>
	<20030909113831.GN14800@fs.tum.de>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 9, bunk@fs.tum.de wrote:
>   CC      fs/nfsd/nfs4xdr.o
> fs/nfsd/nfs4xdr.c: In function `nfsd4_encode_open':
> fs/nfsd/nfs4xdr.c:1773: warning: `return' with a value, in function returning void
> ...
> 
> <--  snip  -->
> 
> 
> The following patch tries to fix it:

Thanks, though I've actually taken a different patch by  Stephen Hemminger <shemminger@osdl.org>.
> 
> BTW:
> Shouldn't the return values of nfsd4_encode_open{,_confirm,_downgrade} 
> be checked in the switch in nfsd4_encode_operation?

No.  There is nothing meaningful in their return values.

NeilBrown
