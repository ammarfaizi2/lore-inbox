Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133015AbRDLMnX>; Thu, 12 Apr 2001 08:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133117AbRDLMnN>; Thu, 12 Apr 2001 08:43:13 -0400
Received: from r108m105.cybercable.tm.fr ([195.132.108.105]:23307 "HELO
	alph.dyndns.org") by vger.kernel.org with SMTP id <S133015AbRDLMnH>;
	Thu, 12 Apr 2001 08:43:07 -0400
To: kowalski@datrix.co.za
Cc: davem@redhat.com, viro@math.psu.edu, jgarzik@mandrakesoft.com,
        adilger@turbolinux.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [CFT][PATCH] Re: Fwd: Re: memory usage - dentry_cache
In-Reply-To: <3AD550F0.8058FAA@mandrakesoft.com>
	<Pine.GSO.4.21.0104120257070.18135-100000@weyl.math.psu.edu>
	<15061.27388.843554.687422@pizda.ninka.net>
	<01041214272403.11986@webman>
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 12 Apr 2001 14:43:05 +0200
In-Reply-To: <01041214272403.11986@webman>
Message-ID: <87zodmmgpy.fsf@mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Kowalski <kowalski@datrix.co.za> writes:

> Hi
> 
> Regarding the patch ....
> 
> I don't have experience with the linux kernel internals but could this patch 
> not lead to a run-loop condition as the only thing that can break our of the 
> for(;;) loop is the tmp==&dentry_unused statement. So if the required number 
> of dentries does not exist and this condition is not satisfied we would have 
> an infinate loop... sorry if this is a silly question.

AFAICT no because of the list_del_init(tmp) call :
When the list will be empty, 
tmp will be equal to dentry_unused.prev (this is a circular list).

-- 
Yoann Vandoorselaere | "Programming is a race between programmers, who try and
MandrakeSoft         | make more and more idiot-proof software, and universe,
                     | which produces more and more remarkable idiots. Until
                     | now, universe leads the race"  -- R. Cook
