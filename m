Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278566AbRKFHUr>; Tue, 6 Nov 2001 02:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278579AbRKFHUl>; Tue, 6 Nov 2001 02:20:41 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:53774 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S278566AbRKFHTc>;
	Tue, 6 Nov 2001 02:19:32 -0500
Message-ID: <3BE78F03.2090600@epfl.ch>
Date: Tue, 06 Nov 2001 08:19:31 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]agp for i820 chipset
In-Reply-To: <3BE6B50A.5010806@epfl.ch> <1004976089.934.12.camel@phantasy> <3BE6D469.8000407@epfl.ch> <1004991553.806.19.camel@phantasy> <1004998482.2277.0.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>
> 
> Hm, one thing to add is if other Intel chipsets have varying APSIZE
> values, and this is all they differ by, and one has an APSIZE of 8bits,
> then you can cheat and just point to that function.
> 


Hello

Finally back to my computer that contains all the info.

In fact, I just gave a quick look to other Intel chipset specs, and I found out 

that the 830, 840, 845, 850, and of course my beloved 820 chipset have a 8 bits 

APSIZE register ! I think this may be the time to write two 'generic' fetch_size

functions : one for the 8 bits register and one for the 16 bits 
register... unless no intel chipset using the generic 'fetch_size' have 
16 bits APSIZE registers, in which case we could replace it...

I'll try to see what I can do, and I will send an update for my patch.

Nicolas.

-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

