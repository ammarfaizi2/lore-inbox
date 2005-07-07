Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVGGMCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVGGMCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVGGLoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:44:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40649 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261312AbVGGLnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:43:06 -0400
Date: Thu, 7 Jul 2005 13:44:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Pekka Enberg <penberg@gmail.com>
Cc: Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
Message-ID: <20050707114415.GA24401@suse.de>
References: <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de> <42C91073.80900@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <42CCEAA7.1010807@grimmer.com> <84144f02050707020765f81c38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f02050707020765f81c38@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07 2005, Pekka Enberg wrote:
> Jens Axboe wrote:
> > > ATA7 defines a park maneuvre, I don't know how well supported it is
> > > yet though. You can test with this little app, if it says 'head
> > > parked' it works. If not, it has just idled the drive.
> 
> On 7/7/05, Lenz Grimmer <lenz@grimmer.com> wrote:
> > Great! Thanks for digging this up - it works on my T42, using a Fujitsu
> > MHT2080AH drive:
> 
> Works on my T42p which uses a Hitachi HTS726060M9AT00 drive. I don't
> hear any sound, though.

Did it say 'head parked'? If the drive is idle, you wont hear anything.
Laptop drives auto-park really quickly themselves. A time ./park
/dev/hda should tell you whether it needed to park or not, if it
executes faster than a few hundred ms it was already parked.

-- 
Jens Axboe

