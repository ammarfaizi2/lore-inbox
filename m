Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVAXW3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVAXW3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVAXW2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:28:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:4063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261684AbVAXW0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:26:31 -0500
Date: Mon, 24 Jan 2005 14:31:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org,
       Michal Ludvig <michal@logix.cz>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050124143109.75ff1ab8.akpm@osdl.org>
In-Reply-To: <20050124115624.GA21457@ghanima.endorphin.org>
References: <20050124115624.GA21457@ghanima.endorphin.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens@endorphin.org> wrote:
>
> This patch adds the ability for a cipher mode to store cipher mode specific
> information in crypto_tfm. This is necessary for LRW's precomputed
> GF-multiplication tables.

These patches clash badly with Michael Ludvig's work:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/cryptoapi-prepare-for-processing-multiple-buffers-at.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/cryptoapi-update-padlock-to-process-multiple-blocks-at.patch

so someone's going to have to rework things.  Ordinarily Michael would go
first due to test coverage.

James, your call please.  Also, please advise on the suitability of
Michael's patches for a 2.6.11 merge.

Thanks.
