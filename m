Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269978AbTHJQHL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269987AbTHJQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:07:11 -0400
Received: from smtp4.wanadoo.fr ([193.252.22.26]:33819 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269978AbTHJQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:07:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 10 Aug 2003 18:08:49 +0200
From: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
To: James Morris <jmorris@intercode.com.au>
Cc: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <kernel@gozer.org>, <axboe@suse.de>
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
In-Reply-To: <Mutt.LNX.4.44.0308110114270.7218-100000@excalibur.intercode.com.au>
References: <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
	<Mutt.LNX.4.44.0308110114270.7218-100000@excalibur.intercode.com.au>
Message-Id: <20030810160706.5D083400211@mwinf0501.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris writes:
 > See RFC 2410, section 2 :-)

This says NULL is the identity function, which is not the same as:

    static void null_encrypt(void *ctx, u8 *dst, const u8 *src)
    { }

In practice this code never gets called because cbc_process() has
a special case for iv==NULL.  But I'd rather see a semantically
correct reference implementation.  Or just leave .cia_encrypt=NULL.

Am I missing something here ?

-- Pascal

