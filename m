Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271660AbRH0G4J>; Mon, 27 Aug 2001 02:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271661AbRH0Gzu>; Mon, 27 Aug 2001 02:55:50 -0400
Received: from ns.suse.de ([213.95.15.193]:24069 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271660AbRH0Gzl>;
	Mon, 27 Aug 2001 02:55:41 -0400
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: VCool - cool your Athlon/Duron during idle
In-Reply-To: <87pu9i7frm.fsf@psyche.kn-bremen.de.suse.lists.linux.kernel> <E15b6Rz-0002hM-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <freitag@alancoxonachip.com>
Date: 27 Aug 2001 08:55:51 +0200
In-Reply-To: Alan Cox's message of "26 Aug 2001 22:27:56 +0200"
Message-ID: <oupk7zqkn48.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Streaming video is not really different to most bus mastering IDE. Its
> just pci card initiated memory writes with timing constraints. For some
> reason having my disk do that makes me very nervous

The bus shutdown is clearly something which shouldn't be done in the normal
idle loop, but only when explicit sleep mode is requested and when the
kernel makes sure that all IO is quiescied [similar to what the sleep code
on the ppc/mac port does; see e.g. 
drivers/macintosh/via-pmu.c:powerbook_sleep_G3]. Such a thing could be 
e.g. controlled from apmd.

-Andi
