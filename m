Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292272AbSCDJFA>; Mon, 4 Mar 2002 04:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292273AbSCDJEv>; Mon, 4 Mar 2002 04:04:51 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:51008 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S292272AbSCDJEg>; Mon, 4 Mar 2002 04:04:36 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Oliver Neukum <oliver@neukum.org>
To: Gerd Knorr <kraxel@bytesex.org>,
        Kernel List <linux-kernel@vger.kernel.org>,
        video4linux list <video4linux-list@redhat.com>
Subject: Re: [patch] 2.5 videodev redesign -- #3
Date: Mon, 4 Mar 2002 09:17:54 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020302151538.A7839@bytesex.org>
In-Reply-To: <20020302151538.A7839@bytesex.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <iss.28ea.3c83389c.370f5.1@mailout.lrz-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 2. März 2002 15:15 schrieb Gerd Knorr:
>   Hi,
>
> I've updated the videodev patch set.  The core part of the redesign is
> attached below for comments.  It is also available here:
> 	http://bytesex.org/patches/2.5/10_videodev-2.5.6-pre2.diff
>
> The 2.4 version of the patch (which is slightly different because
> it keeps the old stuff for backward compatibility) is here:
> 	http://bytesex.org/patches/10_videodev-2.4.19-pre2.diff
>
> I've also updated most v4l drivers (including usb cams this time)
> to the new videodev interface.  Changes are available as individual,
> per driver patches from:
> 	http://bytesex.org/patches/2.5/
>
> There is also one big patch with all changes:
> 	http://bytesex.org/patches/2.5/patch-2.5.6-pre2-kraxel.gz
>
> Comments?  Bugs?  I plan to feed this to Linus soon ...

Hi,

it seems to me that you are not holding the BKL during
the open method of the individual driver. This will
cause races with unplugging on some USB cameras.

	Regards
		Oliver
