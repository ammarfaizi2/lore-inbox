Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267066AbRGJS10>; Tue, 10 Jul 2001 14:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbRGJS1Q>; Tue, 10 Jul 2001 14:27:16 -0400
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:60372 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267066AbRGJS1C>; Tue, 10 Jul 2001 14:27:02 -0400
Message-ID: <01cb01c1096d$e9052bc0$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Andreas Dilger" <adilger@turbolinux.com>,
        "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        "Ext2 development mailing list" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <200107101752.f6AHqXUu022141@webber.adilger.int> <018101c1096a$17e2afc0$b6562341@cfl.rr.com> <20010710191719.B1493@redhat.com>
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246
Date: Tue, 10 Jul 2001 14:27:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So it sounds like theres no advantage then to a swap partition vs file?

----- Original Message -----
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Mike Black" <mblack@csihq.com>
Cc: "Andreas Dilger" <adilger@turbolinux.com>; "linux-kernel@vger.kernel.or"
<linux-kernel@vger.kernel.org>; "Ext2 development mailing list"
<ext2-devel@lists.sourceforge.net>
Sent: Tuesday, July 10, 2001 2:17 PM
Subject: Re: [Ext2-devel] Re: 2.4.6 and ext3-2.4-0.9.1-246


> Hi,
>
> On Tue, Jul 10, 2001 at 01:59:40PM -0400, Mike Black wrote:
> > Yep -- I said __files__ -- I'm less concerned about performance than
> > reliability -- I don't think you can RAID1 a swap partition can you?
>
> You can on 2.4.  2.2 would let you do it but it was unsafe --- swap
> could interact badly with raid reconstruction.  2.4 should be OK.
>
> > Also,
> > having it in files allows me to easily add more swap as needed.
> > As far as journalling mode I just used tune2fs to put a journal on with
> > default parameters so I assume that's full journaling.
>
> The swap code bypasses filesystem writes: all it does is to ask the
> filesystem where on disk the data resides, then it performs IO
> straight to those disk blocks.  The data journaling mode doesn't
> really matter there.
>
> Cheers,
>  Stephen

