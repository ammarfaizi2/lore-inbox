Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUBBCpJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 21:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUBBCpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 21:45:09 -0500
Received: from smtp14.eresmas.com ([62.81.235.114]:20683 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S265578AbUBBCpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 21:45:05 -0500
Message-ID: <401DB9A7.4030104@wanadoo.es>
Date: Mon, 02 Feb 2004 03:44:55 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.1) Gecko/20031114
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       mauelshagen@sistina.com, marcelo.tosatti@cyclades.com,
       hch@infradead.org
Subject: Re: [PATCH] 2.4.25--pre4 VFS lvm_snapshots
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> The patch still doesn't get better by that.  And even if it was this
> would clearly be a feature for 2.6, not 2.4.

Without this patch there is no warranty that a LVM_snapshot is updated
like the FS that is trying to replicate. DANGER !!!

I only see one solution:
to stop FS IO, and then # sync; sync; sync; lvcreate -s ...

Maybe it's needed to write, in the code or a doc, some warning about this
or to put a pointer to this patch :-?

--
Software is like sex, it's better when it's bug free.

