Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbSKSUvZ>; Tue, 19 Nov 2002 15:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267493AbSKSUvY>; Tue, 19 Nov 2002 15:51:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:19840 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267451AbSKSUvX>;
	Tue, 19 Nov 2002 15:51:23 -0500
Date: Tue, 19 Nov 2002 12:58:23 -0800
From: Bob Miller <rem@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5.48] Fixed ifdefs for a label in ncpfs/sock.c
Message-ID: <20021119205823.GB4884@doc.pdx.osdl.net>
References: <20021119185236.GI1986@doc.pdx.osdl.net> <20021119190217.GA8317@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119190217.GA8317@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 07:02:17PM +0000, Dave Jones wrote:
> On Tue, Nov 19, 2002 at 10:52:36AM -0800, Bob Miller wrote:
>  > diff -Nru a/fs/ncpfs/sock.c b/fs/ncpfs/sock.c
>  > --- a/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
>  > +++ b/fs/ncpfs/sock.c	Tue Nov 19 10:31:17 2002
>  > @@ -587,7 +587,9 @@
>  >  				}
>  >  #endif				
>  >  				type = ntohs(server->rcv.buf.type);
>  > +#ifdef CONFIG_NCPFS_PACKET_SIGNING				
>  >  cont:;				
>  > +#endif
>  >  				if (type != NCP_REPLY) {
>  >  					if (datalen - 8 <= sizeof(server->unexpected_packet.data)) {
> 
> Eww, personally I think the fix is worse than the warning.
> 
> 		Dave
I know.  I personally hate #ifdef's and goto's...  I spent more than a few
minutes trying to find a "trivial" way to clean this up, but this was
the best I could do without reorganizing LOTS of code (then it's not
"trivial" anymore).

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
