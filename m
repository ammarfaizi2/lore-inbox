Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWHSS0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWHSS0W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 14:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWHSS0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 14:26:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:5494 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751399AbWHSS0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 14:26:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=irOoxSJgWT1Zjg/BZNUGtrJGGp84wS7LS0OSeNjBrf+gli0FLzDgh1bibMZKhX38vTTkCo2qT67rqdsU6d+Pam9tZ4x/GhbAFizteS5Hu4WqeMOfROJxIEvj7iaWnEdlO3xXfgieNaJad53m7dJx5rdVoGhKxRXS/Zbv8Cwgcpc=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: mplayer-users@mplayerhq.hu
Subject: Re: [MPlayer-users] Weird behaviour in ide-scsi driven dvd playback with 2.6.17.x
Date: Sat, 19 Aug 2006 20:25:58 +0200
User-Agent: KMail/1.8.2
Cc: "Marcin 'Rambo' Roguski" <rambo@id.uw.edu.pl>,
       linux-kernel@vger.kernel.org
References: <20060819193408.10a5297a.rambo@id.uw.edu.pl>
In-Reply-To: <20060819193408.10a5297a.rambo@id.uw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608192025.58331.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 August 2006 19:34, Marcin 'Rambo' Roguski wrote:
> Because of USB camera requirements, I'm currently running double-kernel 
> setup (2.4.32-old, 2.6.17.9-new), and ide-scsi driven CD-ROM/DVD drives.
> 
> While on 2.4.32 mplayer (version doesn't matter happens with svn and 
> pre8- libdvdread compiled as default) plays DVDs perfectly well, on 2.6.17.[6|9] I'm 
> getting such messages from kernel while trying to open them:
> 
> Aug 19 18:06:33 beethoven kernel: Buffer I/O error on device sr1, logical block 4496
> Aug 19 18:06:33 beethoven kernel: Buffer I/O error on device sr1, logical block 4497
> Aug 19 18:06:33 beethoven kernel: Buffer I/O error on device sr1, logical block 4498
> [...]
> and so on...
> 
> The only workaround for now is to use ide-cd, and then it works like a charm, but I'd preffer "unified" setup (unless mplayer can use conditional statements in its config...

Sounds like kernel-side problem. ide-scsi says it have problem reding data
from the media, whereas ide-cd does not have the problem.

Does this happen while you just copy the file with cp?

[adding linux-kernel@vger.kernel.org to CC:]
--
vda
