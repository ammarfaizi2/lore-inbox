Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbREZPbZ>; Sat, 26 May 2001 11:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261471AbREZPbS>; Sat, 26 May 2001 11:31:18 -0400
Received: from crunchy.sound.net ([205.242.194.25]:45036 "HELO
	crunchy.sound.net") by vger.kernel.org with SMTP id <S261351AbREZPap>;
	Sat, 26 May 2001 11:30:45 -0400
Message-ID: <3B0FCCDD.5B5A891C@sound.net>
Date: Sat, 26 May 2001 10:33:49 -0500
From: A Duston <hald@sound.net>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en,el
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Gortmaker, Paul" <p_gortmaker@yahoo.com>,
        "Andersen, Rasmus" <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Esdi patch #8
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net> <3B0D733F.1829DC88@yahoo.com> <20010525164615.C14899@suse.de> <3B0FC26B.D210E416@sound.net> <20010526165800.C553@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
>  --snip--
>
>  and so it continues. This is the easy way to process requests. However,
>  if you can start I/O on more than one buffer at the time (scatter
>  gather), you could then setup your sg tables by browsing the entire
>  request buffer_head list and initiate I/O as needed.
>
>  Bigger requests on the queue, means more I/O in progress being possible.
>  There's no rule that you have to finish a request in one go, so even if
>  you can only handle eg 64 sectors per request with sg, you could do
>  just start I/O on as many segments as you can and simply don't dequeue
>  the request until it's completely done. So the max_sectors patch is
>  never really needed if you know what you are doing.

Can I still gain any advantage if the hardware can only have one I/O inflight
per device?  I am not sure the ps2esdi interface supports this.

Hal Duston
hald@sound.net


