Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbUKXO22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbUKXO22 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUKXO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:26:49 -0500
Received: from colino.net ([213.41.131.56]:32752 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262705AbUKXO0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 09:26:04 -0500
Date: Wed, 24 Nov 2004 15:25:34 +0100
From: Colin Leroy <colin@colino.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124152534.13e07c24@pirandello>
In-Reply-To: <87pt23wdk1.fsf@devron.myhome.or.jp>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87pt23wdk1.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed-Claws 0.9.12cvs166.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004 at 23h11, OGAWA Hirofumi wrote:

Hi, 

> > +			bh = sb_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
> > +			if (bh != NULL) {
> > +				sync_dirty_buffer(bh);
> > +				brelse(bh);
> > +			} else {
> > +				BUG_ON(1);
> > +			}
> > +		}
> 
> FAT12/16 doesn't have FSINFO sector.  And if sb_bread() returns NULL,
> we should return the valid error.

ok, this is probably not the correct way to get the buffer_head for a 
given inode... Do you know what I should use?

-- 
Colin
