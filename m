Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263758AbREYOqg>; Fri, 25 May 2001 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbREYOq1>; Fri, 25 May 2001 10:46:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61958 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263758AbREYOqV>;
	Fri, 25 May 2001 10:46:21 -0400
Date: Fri, 25 May 2001 16:46:15 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: Hal Duston <hald@sound.net>, linux-kernel@vger.kernel.org,
        rasmus@jaquet.dk
Subject: Re: PS/2 Esdi patch #8
Message-ID: <20010525164615.C14899@suse.de>
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net> <3B0D733F.1829DC88@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B0D733F.1829DC88@yahoo.com>; from p_gortmaker@yahoo.com on Thu, May 24, 2001 at 04:46:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24 2001, Paul Gortmaker wrote:
> Hal Duston wrote:
> 
> > http://www.sound.net/~hald/projects/ps2esdi/ps2esdi-2.4.4-patch4
> > 
> > Hal Duston
> > hald@sound.net
> 
> You PS/2 ESDI guys might want to set the max sectors for your
> driver - old default used to be 128, currently 255 (which maybe
> hardware can handle ok?) - the xd and hd drivers were broken until
> a similar fix was added to them.
> 
> Probably makes sense for driver to set it regardless, seeing 
> as default (MAX_SECTORS) has changed several times over last
> few months.  At least then it will be under driver control
> and not at the mercy of some global value.

You might want to assign that max_sect array too, otherwise it's just
going to waste space :-)

Take a look at how ps2esdi handles requests -- always processing just
the first segment. Alas, it doesn't matter how big the request is.

-- 
Jens Axboe

