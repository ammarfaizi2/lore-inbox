Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTAFHq5>; Mon, 6 Jan 2003 02:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbTAFHq5>; Mon, 6 Jan 2003 02:46:57 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54026
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266298AbTAFHq4>; Mon, 6 Jan 2003 02:46:56 -0500
Date: Sun, 5 Jan 2003 23:53:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Lincoln Dale <ltd@cisco.com>
cc: Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator
In-Reply-To: <5.1.0.14.2.20030106175946.02957a30@mira-sjcm-3.cisco.com>
Message-ID: <Pine.LNX.4.10.10301052337150.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Lincoln Dale wrote:

> Andre,
> 
> At 07:38 PM 5/01/2003 -0800, Andre Hedrick wrote:
> >If you know anything about iSCSI RFC draft and how storage truly works.
> >Cisco gets it wrong, they do not believe in supporting the full RFC.
> 
> i can tell you that you're mistaken in your belief.

So Cisco now will turn on and leave the Header and Data Digests on, this
differs from your last initiator test.

> [..]
> >Next try to support any filesystem regardless of platform.
> >Specifically anything Microsoft does to thwart Linux, I have already
> >covered.
> 
> you seem to miss the basic fact that iSCSI is a block-layer 
> transport.  file system != block layer.
> supporting any filesystem with iSCSI is trivial - its just the same as 
> supporting any filesystem on any other block device.

No, you just lost the context of Oliver's question about doing it all from
user space.  Whereas it could be suggested "a target" drops in to the
respective builting FS support.  Why, because attempting to bypass the
double memcpy to/from user/kernel space.

Since it is a pure "block-transport", and execution the raw data transport
to the spindle, the stack does not care about anything about.  Block is a
bit-bucket as what defines SAN.

> [..]
> >In two week I will have NetBSD certified, and 4 weeks later should have
> >Solaris certifed.
> 
> we certainly don't care about any "certifications" you have for NetBSD or 
> solaris.

As you should not, these are data transport QAQC for the respective
"targets".  Initiators make no money, but "targets" do.

> if you wish to discuss the various merits of parts of the iSCSI protocol, 
> there are forums for that kind of thing.
> linux-kernel is not one of them.

Yep, will see you that refector to discuss a hole in the ERL=1 with a
header digest failure w/ the S_BIT set.  It get tossed out and now you end
up with a status sequuence number order problem.

Who owns the mess, Target or Initiator ?

I do not care, because I have both sides covered to support all 11:11
regardless of the support level when talking to your switch with my
initiator, or your initiator talking to my target.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

