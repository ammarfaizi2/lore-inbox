Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265491AbRFVTCo>; Fri, 22 Jun 2001 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265495AbRFVTCe>; Fri, 22 Jun 2001 15:02:34 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44493 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265491AbRFVTCS>;
	Fri, 22 Jun 2001 15:02:18 -0400
Message-ID: <3B33962C.7B401F89@mandrakesoft.com>
Date: Fri, 22 Jun 2001 15:02:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev/nvram driver
In-Reply-To: <3B339380.C0D973CB@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> Who is maintaining the /dev/nvram driver?  I have a couple things I want to
> suggest/ask.

I haven't seen any patches for ages to nvram, so I presume nobody.


> What I really want to know is: should I bother making nvram_open_cnt SMP
> safe, or should it just go away all together.  I vote for the latter
> option, unless something depends on this behavior (in which case, other
> fixes are needed, because it is broken :).

Once you figure out what the best behavior is (which I'm not sure of,
myself), I would suggest using a semaphore in the open and release
methods.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
