Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284925AbRLKH5g>; Tue, 11 Dec 2001 02:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284926AbRLKH50>; Tue, 11 Dec 2001 02:57:26 -0500
Received: from [12.234.19.19] ([12.234.19.19]:34828 "HELO ocean.lucon.org")
	by vger.kernel.org with SMTP id <S284925AbRLKH5L>;
	Tue, 11 Dec 2001 02:57:11 -0500
Date: Mon, 10 Dec 2001 23:57:08 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Linux 1394 <linux1394-devel@lists.sourceforge.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Slow Disk I/O with QPS M3 80GB HD
Message-ID: <20011210235708.A17743@lucon.org>
In-Reply-To: <20011210203452.A3250@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011210203452.A3250@lucon.org>; from hjl@lucon.org on Mon, Dec 10, 2001 at 08:34:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 08:34:52PM -0800, H . J . Lu wrote:
> I have a very strange problem. The disk I/O of my QPS M3 80GB HD is
> very slow under 2.4.10 and above. I got like 1.77 MB/s from hdparm.
> But under 2.4.9, I got 14 MB/s on the same hardware. A 30GB HD has
> consistent I/O performance under 2.4.9 and above on the same bus. Has
> anyone else seen this? Does anyone have a large (>= 80GB) 1394 HD?
> 

I did a binary search. 2.4.10-pre10 is the last good kernel. I got

# hdparm -t /dev/sda

/dev/sda:
 Timing buffered disk reads:  64 MB in  4.40 seconds = 14.55 MB/sec

Even since 2.4.10-pre11 up to 2.4.16, I got about 1.77 MB/sec on the
same hardware. However, I don't have problems with 80GB IDE HD. Has
anyone seen I/O problems on large (>= 80GB) SCSI HD or HD with SCSI
emulation?


H.J.
