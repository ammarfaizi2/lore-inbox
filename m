Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbULNFVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbULNFVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 00:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbULNFVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 00:21:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:59549 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261419AbULNFVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 00:21:00 -0500
Date: Mon, 13 Dec 2004 21:20:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 0/7 (introduction)] cpu-timers and friends
Message-Id: <20041213212032.4c3d596b.akpm@osdl.org>
In-Reply-To: <200412140353.iBE3rVwH008027@magilla.sf.frob.com>
References: <200412140353.iBE3rVwH008027@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> Note that the first patch changes an ill-advised new user-kernel ABI that
>  has been introduced since 2.6.9; I really think we should not let the
>  existing clockid_t encoding change get out in 2.6.10.  I hope this patch
>  (and ideally all the rest) can go into 2.6.10, but reverting the earlier
>  patch so that we have no new clockid_t values at all would be better than
>  letting the existing code for CPU clocks make it into 2.6.10, IMHO.

Assuming that the outcome of any discussion with Christoph is agreement to
proceed with your patches, I'd suggest that for 2.6.10 we apply some
minimal patch which in some way hides the new-since-2.6.9 API changes from
userspace, then we slot this work into 2.6.11.

