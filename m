Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbRLHB6v>; Fri, 7 Dec 2001 20:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285750AbRLHB6l>; Fri, 7 Dec 2001 20:58:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18694 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285747AbRLHB6b>; Fri, 7 Dec 2001 20:58:31 -0500
Message-ID: <3C1173B8.7030905@zytor.com>
Date: Fri, 07 Dec 2001 17:58:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Marvin Justice <mjustice@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: highmem question
In-Reply-To: <Pine.LNX.4.30.0112071404280.29154-100000@mustard.heime.net> <01120719300102.00764@bozo> <3C116CC6.2030808@zytor.com> <01120719534703.00764@bozo> <20011208015446.GC32569@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Fri, Dec 07 2001, Marvin Justice wrote:
> 
>>>There is no way of fixing it.
>>>
>>All I know is that a streaming io app I was playing with showed a drastic 
>>performance hit when the kernel was compiled with CONFIG_HIGHMEM. On W2K we 
>>saw no slowdown with 2 or even 4GB of RAM so I think solutions must exist.
>>
> 
> That's because of highmem page bouncing when doing I/O. There is indeed
> a solution for this -- 2.5 or 2.4 + block-highmem-all patches will
> happily do I/O directly to any page in your system as long as your
> hardware supports it. I'm sure we're beating w2k with that enabled :-)
> 


I didn't realize we were doing page bouncing for I/O in the 1-4 GB range.
 Yes, this would be an issue.

	-hpa




