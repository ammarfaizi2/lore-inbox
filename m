Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbTGJAx5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbTGJAx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:53:57 -0400
Received: from almesberger.net ([63.105.73.239]:17416 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S266224AbTGJAx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:53:56 -0400
Date: Wed, 9 Jul 2003 22:08:25 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
Message-ID: <20030709220825.A22087@almesberger.net>
References: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com> <Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au> <20030707080929.A1848@infradead.org> <20030707.195350.39170946.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030707.195350.39170946.davem@redhat.com>; from davem@redhat.com on Mon, Jul 07, 2003 at 07:53:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I totally disagree.  I think the way we do things today is _STUPID_.
> We put arch code far away from the generic version which makes finding
> stuff very difficult for people inspecting the code for the first time.
> 
> For example, the fact that I have to go groveling in
> arch/foo/lib/whoknowswhatfile.whoknowswhatextension to look at
> the memcpy/checksum/whatever implementation is completely busted.

Hear ! Hear ! Maybe I could also get you interested in the idea
of moving headers with inline functions to the only spot where
they are actually used ?

E.g. most of include/net/tcp.h pretty much only matters for
net/ipv4/. It would be so nice if a  grep -w thing *.[ch]  in
net/ipv4/ would really find all uses of "thing".

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
