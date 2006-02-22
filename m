Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbWBVWR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbWBVWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWBVWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:17:56 -0500
Received: from pat.uio.no ([129.240.130.16]:29843 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751542AbWBVWRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:17:54 -0500
Subject: Re: FMODE_EXEC or alike?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060222220435.GJ28219@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
	 <1140530396.7864.63.camel@lade.trondhjem.org>
	 <20060221232607.GS22042@fieldses.org>
	 <1140564751.8088.35.camel@lade.trondhjem.org>
	 <20060222195721.GC28219@fieldses.org>
	 <1140644216.7879.7.camel@lade.trondhjem.org>
	 <20060222220435.GJ28219@fieldses.org>
Content-Type: text/plain
Date: Wed, 22 Feb 2006 17:17:33 -0500
Message-Id: <1140646653.7879.25.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.121, required 12,
	autolearn=disabled, AWL 1.69, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 17:04 -0500, J. Bruce Fields wrote:
> What I don't understand is the source of the requirement that
> FMODE_WRITE|FMODE_EXEC opens be disallowed.
> 
> The only users of FMODE_EXEC introduced by Oleg's patch use a hardcoded
> FMODE_READ|FMODE_EXEC, so it doesn't seem to impose any constraints on
> the meaning of FMODE_WRITE|FMODE_EXEC.

I understand FMODE_EXEC to mean that we want to call
deny_write_access(). OTOH, FMODE_WRITE is supposed to trigger an
automatic call to get_write_access().

Those two calls are mutually exclusive.

Cheers,
  Trond

