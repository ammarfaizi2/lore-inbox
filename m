Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWGVREf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWGVREf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 13:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWGVREf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 13:04:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:1243 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750968AbWGVREd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 13:04:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FxwsRqCIakObeXNs1HFKRwS+Z8OZmSYX8lHbv07umB+2YOuhiNxWx39tGgsvhtEaLaTYYnyf6ZSsUZhc4OCiIqUaHmlHy428/lzupWZjJ7R2w1QXD8amxVaBgUcIameuuF1xesZcSIgHpMHzVMUHCSqo7KkRsuq5URmhYlzPzmo=
Message-ID: <806dafc20607221004r53a962ebn3e3cef5f320da2bc@mail.gmail.com>
Date: Sat, 22 Jul 2006 13:04:32 -0400
From: "Christopher Montgomery" <xiphmont@gmail.com>
To: "Ian Stirling" <tandra@mauve.plus.com>
Subject: Re: [linux-usb-devel] USB snd-usb-audio wedges lsusb when unplugged while playing sound.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44C259CB.8040901@mauve.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44C21635.5090808@mauve.plus.com>
	 <806dafc20607220949y4ebbc88av99e0e689e1fd687e@mail.gmail.com>
	 <44C259CB.8040901@mauve.plus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/06, Ian Stirling <tandra@mauve.plus.com> wrote:
> I just did it again, and the machine is >90% idle (PII/300), with
> mplayer doing:
>
> ioctl(5, 0x806c4120, 0xbffeffd0)        = -1 ENODEV (No such device)
> write(2, "alsa-lib: pcm_hw.c:406:(snd_pcm_"..., 89) = 89
> write(2, "alsa-space: cannot get pcm statu"..., 50) = 50
> nanosleep({0, 10000000}, NULL)          = 0
> ioctl(5, 0x806c4120, 0xbffeffd0)        = -1 ENODEV (No such device)
>
> about 70 times a second.
> Of course, with other software, it may be different.

Yes, this is certainly not the bug then.  The bug exists regardless,
but it's not what you're hitting.
(I wonder then if mplayer has the opposite problem caused by erroring
out on EPIPE: randomly terminating in the middle of playback 'every
now and then')

Monty
