Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTAECjS>; Sat, 4 Jan 2003 21:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTAECjS>; Sat, 4 Jan 2003 21:39:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:14805 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261305AbTAECjR>;
	Sat, 4 Jan 2003 21:39:17 -0500
Message-ID: <3E179CCF.F4CAE1E5@digeo.com>
Date: Sat, 04 Jan 2003 18:47:43 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@pyxtechnologies.com>
CC: Rik van Riel <riel@conectiva.com.br>, Richard Stallman <rms@gnu.org>,
       andrew@indranet.co.nz, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
References: <Pine.LNX.4.10.10301041740090.421-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2003 02:47:43.0840 (UTC) FILETIME=[D2565E00:01C2B464]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Rik and Richard,
> 
> As you see, I in good faith prior to this holy war, had initiated a formal
> request include a new protocol into the Linux kernel prior to the freeze.
> The extention was requested to insure the product was of the highest
> quality and not limited with excessive erratium as the ratification of the
> IETF modified, postponed, and delayed ; regardless of reason.
> 
> Obviously, PyX had (has) on its schedule to product a high quality target
> which is transport independent on each side of the protocol.  We are not
> sure of this position because of the uncertain nature of the basic usages
> of headers and export_symbols.
> 

I suggest that if a function happens to be implemented as an inline
in a header then it should be treated (for licensing purposes) as
an exported-to-all-modules symbol.  So in Linux, that would be LGPL-ish.

The fact that a piece of kernel functionality happens to be inlined
is a pure technical detail of linkage.

If there really is inlined functionality which we do not wish made
available to non-GPL modules then it should be either uninlined and
not exported or it should be wrapped in #ifdef GPL.
