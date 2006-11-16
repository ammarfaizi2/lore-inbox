Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424599AbWKPXqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424599AbWKPXqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424597AbWKPXqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:46:53 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42193 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1424595AbWKPXqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:46:52 -0500
Date: Thu, 16 Nov 2006 23:52:23 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: eli@dev.mellanox.co.il
Cc: eli@dev.mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: UDP packets loss
Message-ID: <20061116235223.78f13473@localhost.localdomain>
In-Reply-To: <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
References: <60157.89.139.64.58.1163542548.squirrel@dev.mellanox.co.il>
	<18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 20:51:37 +0200 (IST)
eli@dev.mellanox.co.il wrote:

> eventually slow the whole thing to a rate such all parts can handle. But
> is there a way to overcome this situation and to avoid packets drop? If
> this would happen then TCP would work at higher rates as well?? Perhaps
> increase buffers sizes?

Increased buffer sizes can actually paradoxically make the situation
worse. Van Jacobson once claimed that those who do not understand TCP are
doomed to re-invent it.

If you have a very controlled environment then there are alternative flow
control approaches including counting approaches when you know the
underlying transport is basically reliable (or you can tolerate minor
loss). That's roughly speaking the equivalent of TCP with fixed windows
and knowing that the buffering worst cases are the end points.

Alan
