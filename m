Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283377AbRK2SQ4>; Thu, 29 Nov 2001 13:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283373AbRK2SQp>; Thu, 29 Nov 2001 13:16:45 -0500
Received: from okcforum.org ([207.43.150.207]:54021 "EHLO okcforum.org")
	by vger.kernel.org with ESMTP id <S283375AbRK2SQc>;
	Thu, 29 Nov 2001 13:16:32 -0500
Subject: Re: Unresponiveness of 2.4.16 revisited
From: "Nathan G. Grennan" <ngrennan@okcforum.org>
To: Oktay Akbal <oktay.akbal@s-tec.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.42.0111291904190.2184-100000@omega.hbh.net>
In-Reply-To: <Pine.LNX.4.42.0111291904190.2184-100000@omega.hbh.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 29 Nov 2001 12:16:07 -0600
Message-Id: <1007057769.1528.7.camel@cygnusx-1.okcforum.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-29 at 12:09, Oktay Akbal wrote:
> Why do you think that fstab matters for root-fs ? root-fs needs to be 
> mounted to read fstab. So autodetection must be done for root-fs.
> And if the fs has a journal it is ext3. If you do not want that  behaviour
> you might use a option to lilo, but I don't know of any option to specify
> the root-fs-tyoe. Or you need to use an initrd to mount explicit as ext2
> and pivot-root it to / ?
> 
> -- 
> Oktay Akbal

Actually, I think it should respect fstab. It does mount it, then fsck
it while mounted read-only, then remounts(key point) read-write. IMHO it
should remount it with whatever fstab says. I realize this could be a
little tricky, but I bet doable.

