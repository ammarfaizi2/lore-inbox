Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDQQgh>; Wed, 17 Apr 2002 12:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSDQQgg>; Wed, 17 Apr 2002 12:36:36 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:7931 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S293603AbSDQQgg>; Wed, 17 Apr 2002 12:36:36 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 17 Apr 2002 10:34:53 -0600
To: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
Message-ID: <20020417163453.GM20464@turbolinux.com>
Mail-Followup-To: Moritz Franosch <jfranosc@physik.tu-muenchen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <rxxadshj1rh.fsf@synapse.t30.physik.tu-muenchen.de> <20020416165358.E29747@dualathlon.random> <rxxk7r6tkh6.fsf@synapse.t30.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2002  17:26 +0200, Moritz Franosch wrote:
> In cases 9 and 12 where performance is bad, both tested drives are on
> the same IDE controller. Should that matter?

Yes, very much.  IDE is broken in this regard - you can only do I/O
to one device on the IDE channel at the same time.  Either you need
to get additional IDE controllers (about $35 or so) or you split your
devices so that they are on separate IDE channels (i.e. DVD and ZIP
together, HD on the other channel if copying HD <-> DVD and HD <-> ZIP).
Of course with 2 HDs, you should probably keep them on separate channels
also.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

