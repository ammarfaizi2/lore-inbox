Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVADD6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVADD6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 22:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVADD6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 22:58:52 -0500
Received: from dp.samba.org ([66.70.73.150]:52701 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262012AbVADD6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 22:58:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16858.5104.353423.247503@samba.org>
Date: Tue, 4 Jan 2005 14:56:32 +1100
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: sfrench@samba.org, samba-technical@lists.samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp
Subject: Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <3D55717A-5E02-11D9-B689-000393ACC76E@mac.com>
References: <41D9C635.1090703@zytor.com>
	<16857.56805.501880.446082@samba.org>
	<41D9E3AA.5050903@zytor.com>
	<16857.59946.683684.231658@samba.org>
	<41D9EDF6.1060600@zytor.com>
	<16857.62250.259275.305392@samba.org>
	<41D9F65E.3030301@zytor.com>
	<16857.63978.65838.823252@samba.org>
	<AA7F1C76-5DF7-11D9-B689-000393ACC76E@mac.com>
	<16858.1074.740440.917427@samba.org>
	<3D55717A-5E02-11D9-B689-000393ACC76E@mac.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle,

 > I was thinking something more along the lines of a more complex and
 > detailed scheme that is a superset of both NT ACLs and POSIX ACLs.

superset is hard, as a uid_t/gid_t is only superfically similar to a
windows SID. Samba has to do quite a lot of complex stuff to map
between general SIDs and posix IDs. It can't be done in any reasonable
fashion without being able to talk MSRPC to domain controllers, or at
least having a (potentially quite large) persistent database of
mappings.

The schemes that attempt to do general SID -> uid/gid mappings via
fixed algorithmic mappings are hopeless. They are great for toy demos,
but useless for real deployments.

Cheers, Tridge
