Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVAaTou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVAaTou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVAaTn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:43:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50437 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261339AbVAaTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:42:23 -0500
Date: Mon, 31 Jan 2005 20:42:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Paul Blazejowski <diffie@gmail.com>, linux-kernel@vger.kernel.org,
       Nathan Scott <nathans@sgi.com>
Subject: Re: 2.6.11-rc2-mm2
Message-ID: <20050131194221.GD18316@stusta.de>
References: <20050129235653.1d9ba5a9.akpm@osdl.org> <20050130105429.GA28300@infradead.org> <20050130105738.GA28387@infradead.org> <20050130120009.GG3185@stusta.de> <20050130121241.GH3185@stusta.de> <Pine.LNX.4.61.0501302358270.6118@scrub.home> <20050130231055.GA7103@stusta.de> <Pine.LNX.4.61.0501310025360.6118@scrub.home> <20050131151008.GM18316@stusta.de> <Pine.LNX.4.61.0501311616020.30794@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501311616020.30794@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 04:16:56PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Mon, 31 Jan 2005, Adrian Bunk wrote:
> 
> > > Why not just let XFS_FS select EXPORTFS directly:
> > > 
> > > config XFS_FS
> > > 	select EXPORTFS if NFSD
> > 
> > This has the wrong semantics:
> > With NFSD=m and XFS_FS=y it only sets EXPORTFS=m.
> 
> This should do it then:
> 
> config XFS_FS
> 	select EXPORTFS if NFSD!=n

Yes, this seems to work.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

