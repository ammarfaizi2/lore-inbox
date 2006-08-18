Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWHRR5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWHRR5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWHRR5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:57:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32170 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751448AbWHRR5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:57:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EDu4rEMjK2zo5f3vsz0knP379cm4vr4GT1Vps9bjRMjsYe5ZoLSA+55AOKDEoGRcaB3xIe3l6UW8hPuS07iSpeNKUigX5cX+aliD1Ycz6GFu+3xWGefwGsg13r9CG5yWjTJGtC/Yg/hedLjU5ysO+kiTL7LoQZvouZ07WXTiRLg=
Message-ID: <7c3341450608181057j6b4df954v48b993a0891d82dc@mail.gmail.com>
Date: Fri, 18 Aug 2006 18:57:09 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Denis Vlasenko" <vda.linux@googlemail.com>
Subject: Re: mplayer + heavy io: why ionice doesn't help?
Cc: mplayer-users@mplayerhq.hu, linux-kernel@vger.kernel.org
In-Reply-To: <200608181937.25295.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608181937.25295.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Have you followed this:

http://www.mplayerhq.hu/DOCS/HTML/en/rtc.html

Not that it will help, I don't know, but it could be to do with timing.

Nick

On 18/08/06, Denis Vlasenko <vda.linux@googlemail.com> wrote:
> Hi,
>
> I noticed that mplayer's video playback starts to skip
> if I do some serious copying or grepping on the disk
> with movie being played from.
>
> nice helps, but does not eliminate the problem.
> I guessed that this is a problem with mplayer
> failing to read next portion of input data in time,
> so I used Jens's ionice.c from
> Documentation/block/ioprio.txt
>
> I am using it this:
>
> ionice -c1 -n0 -p<mplayer pid>
>
> but so far I don't see any effect from using it.
> mplayer still skips.
>
> Does anybody have an experience in this?
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
