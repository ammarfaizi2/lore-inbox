Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUIGJcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUIGJcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267764AbUIGJcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:32:03 -0400
Received: from ozlabs.org ([203.10.76.45]:48263 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267754AbUIGJcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:32:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16701.32784.10441.884090@cargo.ozlabs.ibm.com>
Date: Tue, 7 Sep 2004 19:32:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jens Axboe <axboe@suse.de>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
In-Reply-To: <20040907080223.GF6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost>
	<20040907080223.GF6323@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:

> __copy_to_user is the unchecking version of copy_to_user.

It doesn't range-check the address, but it does return non-zero
(number of bytes not copied) if it encounters a fault writing to the
user buffer.

Paul.
