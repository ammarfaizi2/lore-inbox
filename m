Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTEBBls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTEBBls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:41:48 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:21518 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262864AbTEBBlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:41:47 -0400
Date: Thu, 1 May 2003 22:54:10 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Steve@ChyGwyn.com, steve@gw.chygwyn.com, hch@infradead.org,
       linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
Message-ID: <20030502015409.GC5356@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, Steve@ChyGwyn.com,
	steve@gw.chygwyn.com, hch@infradead.org,
	linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030501215709.A28210@infradead.org> <200305012135.WAA19582@gw.chygwyn.com> <20030501.142235.91789378.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501.142235.91789378.davem@redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 01, 2003 at 02:22:35PM -0700, David S. Miller escreveu:
>    From: Steven Whitehouse <steve@gw.chygwyn.com>
>    Date: Thu, 1 May 2003 22:35:46 +0100 (BST)

>    > The name is a bit generic for an export function.  What about
>    > seq_release_kfree?

>    Yes, I'd considered that and eventually settled for the non-prefixed
>    version since it followed the pattern set by single_release() which
>    doesn't have the seq_ prefix. I don't mind changing it though if the
>    prefixed version is preferred,
 
> I think a naming convention without a prefix is asking for
> trouble.  I'd ask that you add the prefix, the current convention
> is troublesome and someone ought to clean that up.

Agreed, I also tought of adding it as a generic function, that is the spirit
of ip_seq_release, that is already used several net/ipv4 seq_file routines
and should be deleted in favour of seq_release_private, that is my preferred
name, as it is more general.

- Arnaldo
