Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280419AbRJaTAn>; Wed, 31 Oct 2001 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280420AbRJaTAd>; Wed, 31 Oct 2001 14:00:33 -0500
Received: from [63.231.122.81] ([63.231.122.81]:7018 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280419AbRJaTAO>;
	Wed, 31 Oct 2001 14:00:14 -0500
Date: Wed, 31 Oct 2001 11:59:43 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031115943.K16554@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110311902410.29481-100000@gans.physik3.uni-rostock.de> <Pine.LNX.4.30.0110311926360.29572-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110311926360.29572-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Wed, Oct 31, 2001 at 07:35:47PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  19:35 +0100, Tim Schmielau wrote:
> Sorry, I forgot to set INITIAL_JIFFIES to zero before posting the patch.

Actually, it SHOULD stay non-zero to fix exactly those problems, otherwise
you need to wait a long time to test it...  And the Linux development
process is "developers can't possibly test everything, so users need to
do testing as well.

> Testing with high INITIAL_JIFFIES values unfortunately still discloses
> instability after the wraparound even for an otherwise unpatched kernel.

Exactly my point.  Leave it in.

> This of course needs to be
>    #define INITIAL_JIFFIES 0
> for correct uptime display

Maybe for uptime display only, you could subtract INITIAL_JIFFIES from
jiffies, for printing, but leave the initial value as non-zero?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

