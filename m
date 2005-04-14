Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVDNXDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVDNXDu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVDNXDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:03:44 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:31245 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261634AbVDNXCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:02:05 -0400
Date: Fri, 15 Apr 2005 01:03:17 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
Message-ID: <20050414230317.GA12156@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl> <425EE9CF.4030202@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <425EE9CF.4030202@interia.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 12:08:15AM +0200, Tomasz Chmielewski wrote:
> >>The performance under 2.6 kernels is *very* poor (Timing buffered disk
> >>reads never more than 20 MB/sec); under 2.4 it runs quite fine (Timing
> >>buffered disk reads around 60 MB/sec).
> >
> >
> > 2.4 risk data corruption. 2.6 sata_sil.c contains blacklist for some
> >driver-controller combination.
> >
> > See: http://home-tj.org/m15w/
> 
> ...but this link just doesn't explain why performance is sooo bad with 
> 2.6.11.x kernels (Timing buffered disk reads at 10-20 MB/sec), and is 
> just OK with older 2.6 kernels (Timing buffered disk reads even at about 
> 100 MB/sec with 2.6.8.1).
> 
> any clue?

 The sata_sil blacklist grown over time. Older version didn't mark your
drive as bad. Check sata_sil history at
http://www.linuxhq.com/kernel/file/drivers/scsi/sata_sil.c ,
you may find exact time when your drive got blacklisted.

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

