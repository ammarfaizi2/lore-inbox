Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270992AbRHXIxd>; Fri, 24 Aug 2001 04:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271001AbRHXIxZ>; Fri, 24 Aug 2001 04:53:25 -0400
Received: from mail.broadpark.no ([217.13.4.2]:10198 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S270992AbRHXIxL>;
	Fri, 24 Aug 2001 04:53:11 -0400
From: Paal Chr Birkeland <paalchr@linuxnation.net>
Reply-To: paalchr@linuxnation.net
To: linux-kernel@vger.kernel.org
Subject: Re: Determining maximum partition size on a hard disk
Date: Fri, 24 Aug 2001 10:47:28 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0108241047280B.08728@vixen>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> First I found that the maximum size of the drive Linux reports is not
> the maximum size I get when I calculate it from the drives geometry.
> Secondly, the total drive space reported by linux is not the amount
> available for the maximum partition.
>

tune2fs -m 2 /dev/hd-whatever-hdd

For some reason linux still "eats" 5% of the hdd. This for still beeing able 
to run smooth if hdd is maxed out, or something like that.
 
root@vixen:~# tune2fs -m 2 /dev/hdb1
tune2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Setting reserved blocks percentage to 2 (256034 blocks)

Default is 5% (slackware)

This, I think, is from way back when hdds where alot smaler and then ppl 
forgot all about it (?). 5% of an 80 gig hdd gotta be a lot of wasted space 
and in no way required. I always set it lower (2% as above) and gain more 
useable space. Probably 1% would be enough but who's counting :o)

I dont know if the tune2fs is a slackware feature only, but i doubt it. Then
again I havent really "tried" any other distro.

Inputs ?

-- 
Vennlig hilsen / Regards
Paal Chr Birkeland
admin@linuxnation
