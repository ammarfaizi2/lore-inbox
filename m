Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRJTMCT>; Sat, 20 Oct 2001 08:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272838AbRJTMB7>; Sat, 20 Oct 2001 08:01:59 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:35596 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S272818AbRJTMBt>; Sat, 20 Oct 2001 08:01:49 -0400
Date: Sat, 20 Oct 2001 14:01:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: "'Peter Moscatt'" <pmoscatt@yahoo.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Can't see IDE CDR-W after compile ?
Message-ID: <20011020140116.B654@suse.de>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CA79@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CA79@mail0.myrio.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19 2001, Torrey Hoffman wrote:
> The other driver is the IDE-SCSI emulation layer.  This works better for
> some things, including ripping music CD's.  And, as you have discovered, it
> is a requirement for CDR's.  For example, using the IDE-SCSI driver I can
> rip audio with my Toshiba DVD drive at 10x speed, but with the "normal IDE"
> driver it could not even go at 1x speed.

THat is funny, since the code for ripping audio is in the generic CDROM
layer and this shared by both ide-cd and sr. Exactly the same cdb is
sent down regardless of your setup.

So maybe your ripping program is accessing the CDROM differently
depending on the bus type (eg using sg for sr, maybe?).

-- 
Jens Axboe

