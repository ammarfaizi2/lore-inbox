Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVDYWbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDYWbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVDYWbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:31:11 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:32520 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261262AbVDYWbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:31:01 -0400
Date: Tue, 26 Apr 2005 00:31:00 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: avi@argo.co.il, linux-kernel@vger.kernel.org
Subject: Re: tcp_sendpage and page allocation lifetime vs. iscsi
Message-ID: <20050425223100.GB64842@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"David S. Miller" <davem@davemloft.net>, avi@argo.co.il,
	linux-kernel@vger.kernel.org
References: <20050425170259.GA36024@dspnet.fr.eu.org> <426D40D4.8050900@argo.co.il> <20050425121953.6b5c3278.davem@davemloft.net> <20050425220603.GA64842@dspnet.fr.eu.org> <20050425150840.5f27f77a.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425150840.5f27f77a.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 03:08:40PM -0700, David S. Miller wrote:
> You could do something similar in iSCSI and for now I highly
> suggest that is what you do.

Ok, I'll try to implement that.


> In short, you're using an API in a way it was never designed
> to be used.

Heh, I don't, I'm just debugging it ;-)

It's interesting though that both the 4.x guys (linux-iscsi) and the
5.x ones (openiscsi, now both have merged) did the exact same mistake
while afaik their developments were independant.  There is a
documentation issue there.  If you could put what you just said in
Documentation/*, it should hopefully prevent this kind of
hard-to-track mistakes in the future.

  OG.

