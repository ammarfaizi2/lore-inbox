Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262228AbTDAJtn>; Tue, 1 Apr 2003 04:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbTDAJtn>; Tue, 1 Apr 2003 04:49:43 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:49876 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262228AbTDAJtm>; Tue, 1 Apr 2003 04:49:42 -0500
Date: Tue, 1 Apr 2003 20:02:37 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com
Subject: 2.5.66: slow to friggin slow journal recover
Message-ID: <20030401100237.GA459@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The journal recovery rangers from slow to really friggin slow under
2.5.66 with definate pauses in disk io stretching for 10s of seconds.
This does not happen with 2.5.63 and if I hit ^c on fsck and let the
kernel handle the journal recover for all partitions  on mountime
the recovery under 2.5.66 is either so fast that you don't notice
it or just a buttload faster. Very objective measurements of time but
the slowness of a journal recover as done by fsck is so noticible it's
not funny.

At the time of fsck journal recover or moiunt-time kernel journal
recover DMA is turned on the drive.

e2fsprogs 1.27 is in use. (1.27-2 from debian woody)

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
