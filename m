Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSEFL4T>; Mon, 6 May 2002 07:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314398AbSEFL4S>; Mon, 6 May 2002 07:56:18 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:1700 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S314396AbSEFL4R>; Mon, 6 May 2002 07:56:17 -0400
Message-ID: <3CD66E4C.1010305@linuxhq.com>
Date: Mon, 06 May 2002 07:51:40 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.14 OSS emulation
In-Reply-To: <3CD665A0.2030508@wanadoo.fr> <20020506123035.A26941@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, May 06, 2002 at 01:14:40PM +0200, Pierre Rousselet wrote:
> 
>> From ChangeLog-2.5.14 :
>>
>><hch@infradead.org> (02/05/05 1.545)
>>	[PATCH] fix config.in syntax errors.
>>        - sound uses a bool where it should use a dep_bool
>>
>>This prevents using OSS emulation with ALSA drivers. What is the reason 
>>behind ?
> 
> 
> 2.4.13 used to do (in sound/core/Config.in):
> 
> bool '  OSS API emulation' CONFIG_SND_OSSEMUL $CONFIG_SND
> 
> The bool verb take exaxctly two arguments, the option description
> and the config option itself, if you want additional depencies you
> have to use dep_bool instead.
> 
> If this fix breaks ALSA it only shows that it has even deeper config
> problems - I don't use ALSA and care only about the syntactical
> correctness of that file.


This is very true.  I've had trouble getting my YMFPCI sound to work 
with ALSA probably for this reason: bad configs.  (After all, I was told 
the YMFPCI code is the same for OSS and ALSA).

