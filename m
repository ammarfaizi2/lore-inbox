Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQLAToS>; Fri, 1 Dec 2000 14:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLAToI>; Fri, 1 Dec 2000 14:44:08 -0500
Received: from [193.120.224.170] ([193.120.224.170]:43921 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S129465AbQLATnz>;
	Fri, 1 Dec 2000 14:43:55 -0500
Date: Fri, 1 Dec 2000 19:13:22 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: JP Navarro <navarro@mcs.anl.gov>, <linux-kernel@vger.kernel.org>
Subject: Re: IP fragmentation (DF) and ip_no_pmtu_disc in 2.2 vs 2.4
In-Reply-To: <E141v36-0000Zg-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0012011902010.5623-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000, Alan Cox wrote:

> > Intel PXE uses tftp to download boot images and discards IP packets with
> > the DF bit set; so a tftpd server on 2.4 with the default
>
> Then Intel PXE is buggy and you should go spank whoever provided
> it as well as doing the workarounds. Supporting received frames
> with DF set is mandatory.
>

SGI Indy PROM also has this behaviour (for bootp).

Could we perhaps make ip_no_pmtu_disc a per interface option? the
machine i use as bootp/tftp/nfs server is also a dial-up internet
gateway, and it's a shame to have to lose pmtu discovery across the
board.

regards,

--paulj



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
