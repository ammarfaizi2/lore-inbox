Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267116AbSKSS5V>; Tue, 19 Nov 2002 13:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267397AbSKSS5M>; Tue, 19 Nov 2002 13:57:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8938 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267290AbSKSS47>;
	Tue, 19 Nov 2002 13:56:59 -0500
Date: Tue, 19 Nov 2002 19:02:17 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Bob Miller <rem@osdl.org>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5.48] Fixed ifdefs for a label in ncpfs/sock.c
Message-ID: <20021119190217.GA8317@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Bob Miller <rem@osdl.org>, trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20021119185236.GI1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119185236.GI1986@doc.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 10:52:36AM -0800, Bob Miller wrote:
 > diff -Nru a/fs/ncpfs/sock.c b/fs/ncpfs/sock.c
 > --- a/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
 > +++ b/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
 > @@ -587,7 +587,9 @@
 >  				}
 >  #endif				
 >  				type = ntohs(server->rcv.buf.type);
 > +#ifdef CONFIG_NCPFS_PACKET_SIGNING				
 >  cont:;				
 > +#endif
 >  				if (type != NCP_REPLY) {
 >  					if (datalen - 8 <= sizeof(server->unexpected_packet.data)) {

Eww, personally I think the fix is worse than the warning.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
