Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBMWfu>; Tue, 13 Feb 2001 17:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBMWfk>; Tue, 13 Feb 2001 17:35:40 -0500
Received: from garlic.amaranth.net ([216.235.243.195]:37647 "EHLO
	garlic.amaranth.net") by vger.kernel.org with ESMTP
	id <S129051AbRBMWfa>; Tue, 13 Feb 2001 17:35:30 -0500
Message-ID: <3A89B693.B0A0ADF9@egenera.com>
Date: Tue, 13 Feb 2001 17:34:59 -0500
From: Phil Auld <pauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stale super_blocks in 2.2
In-Reply-To: <E14Snw6-00036v-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > does not do anything to invalidate the buffers associated with the
> > unmounted device. We then rely on disk change detection on a
> > subsequent mount to prevent us from seeing the old super_block.
> 
> 2.2 yes, 2.4 no

That can be a problem for fiber channel devices. I saw some issues with
invalidate_buffers and page caching discussed in 2.4 space. Any reasons 
come to mind why I shouldn't call invalidate on the the way down instead 
(or in addition)?


Thanks,

Phil
 
------------------------------------------------------
Philip R. Auld                         Kernel Engineer
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
