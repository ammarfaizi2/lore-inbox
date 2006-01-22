Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWAVTHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWAVTHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAVTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:07:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51392 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751314AbWAVTHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:07:23 -0500
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
From: Arjan van de Ven <arjan@infradead.org>
To: Ariel <askernel2615@dsgml.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
	 <1137917798.3328.2.camel@laptopd505.fenrus.org>
	 <1137918044.3328.6.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 20:07:21 +0100
Message-Id: <1137956841.3328.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 13:51 -0500, Ariel wrote:
> On Sun, 22 Jan 2006, Arjan van de Ven wrote:
> 
> > On Sun, 2006-01-22 at 09:16 +0100, Arjan van de Ven wrote:
> >> On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:
> >>> I have a memory leak in scsi_cmd_cache.
> 
> >> does this happen without the binary nvidia driver too? (it appears
> >> you're using that). That's a good datapoint to have if so...
> 
> I had the exact same nvidia driver with 2.6.12 (just recompiled) and it 
> didn't happen there.
> 
> But just in case I used slabtop to watch scsi_cmd_cache grow by 1.24KB per 
> second (104MB per day), then I rmmoded nvidia and watched it grow by 
> 1.16KB per 

please repeat this without nvidia ever being loaded. Just having a
module loaded before can already cause corruption that ripples through
later, so just unloading is not enough to get a clean result.

<lsmod snipped>

I see you also use vmware. The other person who reported this also uses
vmware. Could you please repeat the test without BOTH the nvidia and
vmware modules?



