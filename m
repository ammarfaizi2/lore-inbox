Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWHJGD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWHJGD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWHJGD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:03:29 -0400
Received: from mx1.suse.de ([195.135.220.2]:49885 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161048AbWHJGD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:03:28 -0400
From: Neil Brown <neilb@suse.de>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Date: Thu, 10 Aug 2006 16:03:25 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17626.52269.828274.831029@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Urgent help needed on an NFS question, please help!!!
In-Reply-To: message from Xin Zhao on Thursday August 10
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	<17626.49136.384370.284757@cse.unsw.edu.au>
	<4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 10, uszhaoxin@gmail.com wrote:
> Many thanks for your kind help!
> 
> Your answer is what I expected. But what frustrated me is that I
> cannot find the code that verifies the generation number in NFS V3
> codes. Do you know where it check the generation number?

NFSD doesn't.  The individual filesystem does.  You need to look in
the filesystem code.

Some filesystems use common code from fs/exportfs/expfs.c
See "export_iget".

NeilBrown.
