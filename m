Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131997AbQKWO6G>; Thu, 23 Nov 2000 09:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131991AbQKWO55>; Thu, 23 Nov 2000 09:57:57 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:13833 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S131700AbQKWO5k>; Thu, 23 Nov 2000 09:57:40 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14877.10577.518203.721355@wire.cadcamlab.org>
Date: Thu, 23 Nov 2000 08:27:29 -0600 (CST)
To: cmedia <cltien@cmedia.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux driver for c-media cm8x38 ver 4.12 released
In-Reply-To: <3A1C62AA.5D4579B3@cmedia.com.tw>
        <20001123033948.R2918@wire.cadcamlab.org>
        <3A1D1998.5A22EA7C@cmedia.com.tw>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ChenLi Tien]
> > I don't think the (2,3,0) ifdef is necessary.  Just use the labeled
> > initializers for all kernels.  See also cm_audio_fops, cm_dsp_fops,
> > cm_midi_fops, cm_dmfm_fops.
> 
> Yes, as 2.3.x series is not for end-user, I can remove them. I keep it for
> easy to tell what's different for kernel 2.3 and 2.4.

What I meant was, the code which you have '#if version >= 2.3.0' is
also valid for 2.2.  You should not have any conditional code there
except the 'owner:' member, which is '#if version >= 2.4.0'.

> > No need for '#ifdef MODULE'.
> 
> I will remove it if kernel 2.2 can work.

It can.  I checked 2.2.0.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
