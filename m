Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVKCQTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVKCQTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVKCQTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:19:45 -0500
Received: from mail.collax.com ([213.164.67.137]:37328 "EHLO
	kaber.coreworks.de") by vger.kernel.org with ESMTP id S1030371AbVKCQTn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:19:43 -0500
Message-ID: <436A3880.9000104@trash.net>
Date: Thu, 03 Nov 2005 17:19:12 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051011 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: Kris Katterjohn <kjak@users.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, jschlst@samba.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c;
 kernel 2.6.14
References: <5b1bc8f2a7f34523b323fc1b58ef4c26.kjak@ispwest.com> <20051103065809.GC27232@gaz.sfgoth.com>
In-Reply-To: <20051103065809.GC27232@gaz.sfgoth.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> Kris Katterjohn wrote:
> 
>>>So I guess use my patch and take "inline" off? What do you think?
> 
> Well the original author presumably thought that the fast-path of
> load_pointer() was critical enough to keep inline (since it can be run many
> times per packet)  So they made the deliberate choice of separating it
> into two functions - one inline, one non-inline.

Exactly. __load_pointer is only called rarely, while load_pointer is
called whenever data needs to be read from the packet. It shouldn't
be changed without any justification.
