Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTJ3SOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 13:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbTJ3SOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 13:14:32 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:61673 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S262729AbTJ3SOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 13:14:31 -0500
Message-ID: <3FA15506.B9B76A5D@users.sourceforge.net>
Date: Thu, 30 Oct 2003 20:14:30 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Slusky <sluskyb@paranoiacs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Slusky wrote:
> The attached patch changes the loop device transfer functions (including
> cryptoloop transfers) to accept page/offset pairs instead of virtual
> addresses, and removes the redundant kmaps in do_lo_send, do_lo_receive,
> and loop_transfer_bio. Per Andrew Morton's request a while back.

Cryptoloop is not the only user of loop transfer interface. Please don't
change that interface as it breaks code outside of mainline kernel.

Cryptoapi interface is quite broken. Your change extends that breakage to
loop transfer interface. Please don't do that.

Linus, please don't apply this patch.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
