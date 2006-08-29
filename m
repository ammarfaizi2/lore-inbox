Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWH2MZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWH2MZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWH2MZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:25:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45205 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751347AbWH2MZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:25:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829115737.GB32714@infradead.org> 
References: <20060829115737.GB32714@infradead.org>  <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com> <20060825193709.11384.79794.stgit@warthog.cambridge.redhat.com> <20060827212136.GA12710@tuatara.stupidest.org> 
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Wedgwood <cw@f00f.org>, David Howells <dhowells@redhat.com>,
       axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/18] [PATCH] BLOCK: Don't call block_sync_page() from AFS [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 13:25:08 +0100
Message-ID: <15995.1156854308@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> AFS never sets a backing_dev_info on it's own and thus uses
> &default_backing_dev_info which sets the unplug_io_fn to
> default_unplug_io_fn.  default_unplug_io_fn is a no-op, and thus
> block_sync_page does nothing for AFS.

I'm sure I used to require this for when there was a local cache on disk.
Maybe things have changed, or maybe I'm misremembering.

David
