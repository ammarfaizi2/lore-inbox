Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316265AbSEKTgc>; Sat, 11 May 2002 15:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316266AbSEKTgb>; Sat, 11 May 2002 15:36:31 -0400
Received: from ns.suse.de ([213.95.15.193]:526 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316265AbSEKTgb>;
	Sat, 11 May 2002 15:36:31 -0400
Date: Sat, 11 May 2002 21:36:30 +0200
From: Dave Jones <davej@suse.de>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, andre@linux-ide.org
Subject: Re: Linux 2.5.14-dj2
Message-ID: <20020511213630.A30904@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Rudmer van Dijk <rudmer@legolas.dynup.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>, andre@linux-ide.org
In-Reply-To: <4.1.20020511114723.009c8270@pop.cablewanadoo.nl> <20020508225147.GA11390@suse.de> <4.1.20020511114723.009c8270@pop.cablewanadoo.nl> <20020511191406.S5262@suse.de> <4.1.20020511205025.009703a0@pop.cablewanadoo.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 09:04:20PM +0200, Rudmer van Dijk wrote:
 > >http://linus.bkbits.net:8080/linux-2.5/cset@1.513.1.14?nav=index.html
 > and still the patch I included applied to 2.5.14-dj2... 

*boggle* $deity knows how.
I just checked. From a clean 2.4.14, with -dj2 patch applied, that
segment of code reads..

#if SUPPORT_SLOW_DATA_PORTS
        if (drive->channel->slow)
            ata_write_slow(drive, buffer, wcount);
        else
#endif 
            ata_write_16(drive, buffer, wcount);
    }

So this part..

 > > > - 			ata_write_16(drive, buffer, wcount<<1);
 > > > + 			ata_write_16(drive, buffer, wcount);

Should reject (or at least say already applied)

It may be patch(1) being funky, and doing something silly like adding the
same patch twice (something thats bitten me a few times, and has also happened
in Linus' tree once or twice).

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
