Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281552AbRLKQF0>; Tue, 11 Dec 2001 11:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281691AbRLKQFQ>; Tue, 11 Dec 2001 11:05:16 -0500
Received: from arsenal.visi.net ([206.246.194.60]:52610 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S281552AbRLKQFL>;
	Tue, 11 Dec 2001 11:05:11 -0500
Date: Tue, 11 Dec 2001 11:05:07 -0500
From: Ben Collins <bcollins@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Linux 1394 <linux1394-devel@lists.sourceforge.net>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow Disk I/O with QPS M3 80GB HD
Message-ID: <20011211110507.H22537@visi.net>
In-Reply-To: <20011210203452.A3250@lucon.org> <20011210235708.A17743@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011210235708.A17743@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 11:57:08PM -0800, H . J . Lu wrote:
> On Mon, Dec 10, 2001 at 08:34:52PM -0800, H . J . Lu wrote:
> > I have a very strange problem. The disk I/O of my QPS M3 80GB HD is
> > very slow under 2.4.10 and above. I got like 1.77 MB/s from hdparm.
> > But under 2.4.9, I got 14 MB/s on the same hardware. A 30GB HD has
> > consistent I/O performance under 2.4.9 and above on the same bus. Has
> > anyone else seen this? Does anyone have a large (>= 80GB) 1394 HD?
> > 
> 
> I did a binary search. 2.4.10-pre10 is the last good kernel. I got
> 
> # hdparm -t /dev/sda
> 
> /dev/sda:
>  Timing buffered disk reads:  64 MB in  4.40 seconds = 14.55 MB/sec

Have you checked the way that your ohci and sbp2 devices are detected
under each case? Most notably the max packet size.

Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
