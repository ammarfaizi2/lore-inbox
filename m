Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRAUNFB>; Sun, 21 Jan 2001 08:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbRAUNEw>; Sun, 21 Jan 2001 08:04:52 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:38920 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129830AbRAUNEj>; Sun, 21 Jan 2001 08:04:39 -0500
Date: Sun, 21 Jan 2001 14:04:33 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andre Hedrick <andre@linux-ide.org>,
        Alan Chandler <alan@chandlerfamily.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Message-ID: <20010121140433.A1068@gondor.com>
In-Reply-To: <20010120215641.A1818@suse.cz> <Pine.LNX.4.10.10101201301200.657-100000@master.linux-ide.org> <20010121104606.A398@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010121104606.A398@suse.cz>; from vojtech@suse.cz on Sun, Jan 21, 2001 at 10:46:06AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 10:46:06AM +0100, Vojtech Pavlik wrote:
> Ok, the VIA driver from clean 2.2.18 does nothing. It doesn't even use
> hardcoded timings. It doesn't touch any timing tables. It just blindly
> enables prefetch and writeback in the chips. The thing works because it
> relies on BIOS to set things up correctly, and this is often the case,
> yes.

If BIOS is often correct: Is it possible to read these values and compare
them to the values linux calculates? If both match: OK, continue. If they
are different: Either BIOS or linux is wrong, print a warning and disable
DMA (or go to some other kind of 'safe mode').

Just an idea, I don't know anything about chipsets and IDE timings ;-)

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
