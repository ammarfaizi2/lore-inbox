Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290482AbSARS0h>; Fri, 18 Jan 2002 13:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290588AbSARS03>; Fri, 18 Jan 2002 13:26:29 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:60120 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290482AbSARS0M>; Fri, 18 Jan 2002 13:26:12 -0500
Message-ID: <3C4868C3.5050107@redhat.com>
Date: Fri, 18 Jan 2002 13:26:11 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jean-Marc Valin <valj01@gel.usherb.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Full-duplex not working with i810_audio
In-Reply-To: <1011369443.1395.15.camel@idefix.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin wrote:

> I can't get full-duplex audio to work on my laptop with 2.4.17 (using
> the i810_audio sound driver). I know my card (ADI 188x WDM) supports it
> because it works fine with the commercial OSS. 
> 
> In the sample code:
>    fd = open("/dev/dsp", O_RDWR);
>    ioctl(fd, SNDCTL_DSP_SETDUPLEX, 0)
> I get:
> SNDCTL_DSP_SETDUPLEX: Invalid argument


That ioctl is not supported in the base i810 sound driver.


> Also, when using the "rec" (based on sox) utility, my kernel crashes
> completely (no panic, no oops, nothing else happens).


Download the updated i810_audio.c file from my web site and let me know if 
basic recording still crashes for you 
(http://people.redhat.com/dledford/i810_audio.c.gz)


> My setup is:
> Compaq Presario 1720CA
> PIII mobile 1 GHz / 256 MB RAM
> ATI Mobility Radeon M6 / 8 MB
> ADI 188x WDM sound chip (on-board)
> RedHat 7.2/2.4.17
> 
> Can anyone help me? 
> 
> 	Jean-Marc
> 
> P.S. Please CC to me, as I am not subscribed to the list
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

