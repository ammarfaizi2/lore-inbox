Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293686AbSCKLgE>; Mon, 11 Mar 2002 06:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293708AbSCKLfz>; Mon, 11 Mar 2002 06:35:55 -0500
Received: from pc-62-31-74-46-ed.blueyonder.co.uk ([62.31.74.46]:32128 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S293686AbSCKLfg>; Mon, 11 Mar 2002 06:35:36 -0500
Date: Mon, 11 Mar 2002 11:34:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Jeremy Higdon <jeremy@classic.engr.sgi.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <20020311113446.A10150@redhat.com>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <E16heCm-0000Q5-00@starship.berlin> <10203032021.ZM443706@classic.engr.sgi.com> <E16hl4R-0000Zx-00@starship.berlin> <phillips@bonn-fries.net> <10203032209.ZM424559@classic.engr.sgi.com> <20020304165216.A1444@redhat.com> <3C8AEDFC.502CAD04@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8AEDFC.502CAD04@torque.net>; from dougg@torque.net on Sun, Mar 10, 2002 at 12:24:12AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 10, 2002 at 12:24:12AM -0500, Douglas Gilbert wrote:

> > FUA is not available on WRITE6, only WRITE10 or WRITE12 commands.
> 
> Stephen,
> FUA is also available on WRITE16.

I said WRITE6, not WRITE16. :-)  WRITE6 uses the low 5 bits of the LUN
byte for the top bits of the block number; WRITE10 and later use those
5 bits for DPO/FUA etc.  But WRITE6 is a horribly limited interface:
you only have 21 bits of block number for a start, so it's limited to
1GB on 512-byte-sector devices.  We can probably ignore WRITE6 safely
enough.

--Stephen
