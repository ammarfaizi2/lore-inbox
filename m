Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289576AbSAONkS>; Tue, 15 Jan 2002 08:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289549AbSAONkI>; Tue, 15 Jan 2002 08:40:08 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:59407 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S289576AbSAONkF>;
	Tue, 15 Jan 2002 08:40:05 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 15 Jan 2002 14:20:17 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-ID: <20020115142017.D8191@bytesex.org>
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com> <E16QETz-0002yD-00@the-village.bc.nu> <20020115004205.A12407@werewolf.able.es> <slrna480cv.68d.kraxel@bytesex.org> <20020115121424.10bb89b2.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115121424.10bb89b2.skraw@ithnet.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 12:14:24PM +0100, Stephan von Krawczynski wrote:
> On 15 Jan 2002 10:17:03 GMT
> Gerd Knorr <kraxel@bytesex.org> wrote:
> 
> > MM wise it shouldn't make a difference whenever you are using 0.7.83 or
> > 0.7.88 (I've mailed 0.7.88 patches to macelo for 2.4.18 btw).  The 0.8.x
> > versions have a complete different way to do the memory management.
> 
> No vmallocs?

Yes.  Instead of remapping vmalloced kernel memory it gives you shared
anonymous pages, then does zerocopy DMA using kiobufs.  You may run in
trouble with >4GB machines.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
