Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbQKCAIw>; Thu, 2 Nov 2000 19:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbQKCAIm>; Thu, 2 Nov 2000 19:08:42 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:23812 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129718AbQKCAIX>;
	Thu, 2 Nov 2000 19:08:23 -0500
Date: Thu, 2 Nov 2000 23:08:44 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: "CRADOCK, Christopher" <cradockc@oup.co.uk>
Cc: "'M.H.VanLeeuwen'" <vanl@megsinet.net>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: RE: Linux-2.4.0-test10
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk>
Message-ID: <Pine.LNX.4.21.0011022306180.14650-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a similar hardware list and I don't observe any of these problems on
> 2.4.0-test10x. Is it possibly a hardware conflict somewhere?
> 
> What I do see occasionally is if X was ever heavy on the memory usage (say
> I've run GIMP for a couple of hours) then the text console's font set gets
> trashed until the next reboot. Console driver failing to reset something?

No! The X server resets the VGA mode including resetting the fonts. See
xc/programs/Xserver/hw/xfree86/vgahw to see how XF4.0 switchs between X
and vgacon. It see under heavy pressure X fails to reset the video
hardware on it own :-( 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
