Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHAHhYpyvi/tRWuzpkOfTiGkIA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 10:33:53 +0000
Message-ID: <01c001c415a4$70074140$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:27 +0100
Content-Class: urn:content-classes:message
Importance: normal
From: "Jens Axboe" <axboe@suse.de>
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
To: <Administrator@smtp.paston.co.uk>
Cc: "Hugang" <hugang@soulinfo.com>, "Bart Samwel" <bart@samwel.tk>,
        "Andrew Morton" <akpm@osdl.org>, <smackinlay@mail.com>,
        "Bartek Kania" <mrbk@gnarf.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] laptop-mode-2.6.0 version 5
References: <3FF3887C.90404@samwel.tk> <20031231184830.1168b8ff.akpm@osdl.org> <3FF43BAF.7040704@samwel.tk> <3FF457C0.2040303@samwel.tk> <20040101183545.GD5523@suse.de> <20040102170234.66d6811d@localhost> <20040102112733.GA19526@suse.de> <20040102193849.6ff090da@localhost> <20040102120327.GA19822@suse.de> <16375.57972.132841.32878@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16375.57972.132841.32878@wombat.chubb.wattle.id.au>
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:28.0218 (UTC) FILETIME=[70A94DA0:01C415A4]

On Sun, Jan 04 2004, Peter Chubb wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
> 
> Jens> The dump printk() needs to be changed anyways, the rw
> Jens> deciphering is not correct. Something like this is more
> Jens> appropriate:
> 
> Jens>	if (unlikely(block_dump)) { 
> Jens>		char b[BDEVNAME_SIZE];
> Jens>		printk("%s(%d): %s block %Lu on %s\n", current->comm, current-> pid, (rw & WRITE) ? "WRITE" : "READ",
> Jens>		(u64) bio->bi_sector, bdevname(bio->bi_bdev, b)); 
> Jens>	}
> 
> Please cast to (unsigned long long) not (u64) because on 64-bit
> architectures u64 is unsigned long, and you'll get a compiler warning.

Yeah Andrew noted the same thing, my bad.

-- 
Jens Axboe

