Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTAPIoB>; Thu, 16 Jan 2003 03:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTAPIoB>; Thu, 16 Jan 2003 03:44:01 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:2241
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S265222AbTAPIoA>; Thu, 16 Jan 2003 03:44:00 -0500
Message-ID: <3E26731D.1010104@tupshin.com>
Date: Thu, 16 Jan 2003 00:53:49 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Bertrand_VIEILLE_=5BB=E9bert=5D=22?= 
	<Bertrand.Vieille@crans.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer kernel 2.4.21-pre3-ac4
References: <20030115040016$0ac9@gated-at.bofh.it> <20030115071009$2e07@gated-at.bofh.it> <20030115221017$1adf@gated-at.bofh.it> <2973405.67FiTA12eK@adelaide.crans.org>
In-Reply-To: <2973405.67FiTA12eK@adelaide.crans.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bertrand VIEILLE [Bébert] wrote:

>Hello !!
>
>I have the same problem with -ac tree.
>
>Alan Cox said he suspected several things to induce this oops:
>
>* Guess #1 is reverting mm/shmem.c.
>* Guess #2 is reverting the buffer cache changes.
>* Guess #3 is new IDE + highmem
>
no highmem enabled here.

>* Guess #4 is quota related (are people seeing the problem with quota
>disabled ?)
>
I do have quota enabled, so I'll try it without just to double check 
your results.

>
>Personnally, I answered him, I dont'have quota enabled, so Guess #4 doesn't
>exist anymore.
>
>  
>
It's looking like shmem or buffer cache.

The call trace that I posted certainly looks more like the buffer cache, 
but obviously doesn't eliminate shmem as the culprit. Is there an easy 
way to back out one or the other of these changes? I'm happy to do some 
testing.

-Tupshin

