Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbVIVNT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbVIVNT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbVIVNT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:19:26 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:3232 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030323AbVIVNTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:19:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=S7ZMubocpGb6Pg82A4YZUf8GNHkgrFDyU7GDXpXDHfq5BzL5mLR5AUN6QKglgjw9vpzHR22G2ykG57NvAIRQVsTphnWANyhC/2Nb6kXYaDSxOcfGKk0M3AZM7w9QO+3IsawqPm+Z+f72CSDf0/9Wf22w7RDsvNqiTguZazVLA+4=
Date: Thu, 22 Sep 2005 09:16:08 -0400
From: Florin Malita <fmalita@gmail.com>
To: "Jason R. Martin" <nsxfreddy@gmail.com>
Cc: akpm@osdl.org, davem@davemloft.net, ctindel@users.sourceforge.net,
       fubar@us.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       bonding-devel@lists.sourceforge.net
Subject: Re: [PATCH] channel bonding: add support for device-indexed
 parameters
Message-Id: <20050922091608.5ec2724c.fmalita@gmail.com>
In-Reply-To: <c295378405092123032534d93b@mail.gmail.com>
References: <20050922000444.369c32c2.fmalita@gmail.com>
	<c295378405092123032534d93b@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005 23:03:53 -0700
"Jason R. Martin" <nsxfreddy@gmail.com> wrote:
> Personally I think working to get the sysfs support finished in
> bonding and stop relying on module parameters to configure bonds would
> be better, since bonds will truly be independent of each other and be
> able to be added and removed on the fly.  Having worked with a
> previous attempt to set per-bond values through module parameters
> (http://marc.theaimsgroup.com/?t=110558187800001&r=1&w=2), it's easy
> to get pretty crazy.

Agreed - that would be a better configuration interface, but I don't see
why we couldn't support module parameter arrays too. Especially since
the changes are minimal and don't break the ABI/ifenslave
compatibility/etc.

IMHO the "primary" semantics are completely broken right now and this
is a possible fix for it.

> For example, you can have more than one
> arp_ip_target, and they really should be per bond as well, so how do
> you divvy those up via module parameters?

Yup, arp_ip_target is one parameter which doesn't lend itself to this
scheme and this is exactly why the patch doesn't try to fix it.

Florin
