Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271760AbRHURma>; Tue, 21 Aug 2001 13:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271761AbRHURmU>; Tue, 21 Aug 2001 13:42:20 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19437 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271760AbRHURmG>; Tue, 21 Aug 2001 13:42:06 -0400
Message-ID: <3B829D73.20309@redhat.com>
Date: Tue, 21 Aug 2001 13:42:11 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810 audio doesn't work with 2.4.9
In-Reply-To: <E15ZC3v-0007tI-00@the-village.bc.nu> <200108211733.f7LHXoA00491@hal.astr.lu.lv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:

> Sorry, my fault:
> 
> seems that i810_audio.c  from 2.4.7 and 2.4.8 works, but both from 2.4.9 and
> 2.4.8-ac8 does not ("suceeded" not to copy right version of this file when
> testing previous time, so had one from 2.4.7 twice)

(hmmm, what changes went into 2.4.9 kernel for this driver, I haven't 
looked?)

So, Alan, I noticed that in the same ac kernel that you applied my 
updates, you also applied some OSS correctness patch from somewhere.  I 
think someone sent you a bogus patch.  I've fixed this problem with 
artsd once before.  My latest patch didn't touch the GETOSPACE code, and 
obviously that's where this problem with artsd comes from, so my patch 
wasn't it.  I haven't seen this other patch, but at least the GETOSPACE 
changes need to be trashed.



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

