Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130044AbRCFJRy>; Tue, 6 Mar 2001 04:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130062AbRCFJRp>; Tue, 6 Mar 2001 04:17:45 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:49414 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130045AbRCFJR0>;
	Tue, 6 Mar 2001 04:17:26 -0500
Date: Tue, 6 Mar 2001 10:16:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-ac12 unknown southbridge
Message-ID: <20010306101654.A1281@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0103060953360.2221-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0103060953360.2221-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Tue, Mar 06, 2001 at 10:09:05AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 10:09:05AM +0100, Mike Galbraith wrote:

> The driver forget what it always called a vt82c596b before.  Reverting
> the below brought it back on-line, and all seems well again.  (hope I
> don't receive any unpleasant suprises.. I've not the foggiest clue what
> that number means;)
> 
> -	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x12, 0x2f, VIA_UDMA_66 },
> +	{ "vt82c596b",	PCI_DEVICE_ID_VIA_82C596,   0x10, 0x2f, VIA_UDMA_66 },

Can you verify it's a 596b and not 596a? Preferably by looking on the
chip? This change was brought in because I wasn't sure for the 10 and 11
revisions. 586a doesn't have a functional UDMA66 engine and causes
crashes if programmed to UDMA66.

> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 11)

It's the revision number - 11 in your case.

-- 
Vojtech Pavlik
SuSE Labs
