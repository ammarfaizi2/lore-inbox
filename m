Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277713AbRK0Mtm>; Tue, 27 Nov 2001 07:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277738AbRK0Mtc>; Tue, 27 Nov 2001 07:49:32 -0500
Received: from dmb001.rug.ac.be ([157.193.78.1]:63163 "HELO dmb.rug.ac.be")
	by vger.kernel.org with SMTP id <S277713AbRK0MtV>;
	Tue, 27 Nov 2001 07:49:21 -0500
Message-ID: <3C038BE6.3060605@dmb.rug.ac.be>
Date: Tue, 27 Nov 2001 13:49:42 +0100
From: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Organization: RUG/VIB - Dept. Molecular Biology
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, abraham@2d3d.co.za,
        linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> <3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy> <3C02BF41.1010303@xs4all.be> <20011127101148.C5778@crystal.2d3d.co.za> <3C034CAE.2090103@dmb.rug.ac.be> <3C036F83.2000903@dmb.rug.ac.be> <20011127121228.0df6db46.skraw@ithnet.com> <3C037C73.3090003@epfl.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Aspert wrote:

> 
>>
>> Ok, since performance and detection seems just ok, I would suggest the 
>> attached
>> patch as a fix. Unlike Nicolas I don't see a need for an additional 
>> i830MP
>> patch, its only the correct detection of the different i830 setups 
>> that needs
>> to be done IMHO.
>> If there are no further complaints we should submit the patch. What do 
>> you
>> think Nicolas?
>>
> 
> Well, I prefer my version on the patch (of course :-), and I find it 
> cleaner. Let me explain why : by just adding the 'break', you will fall 
> back to the generic initialization routines, which work in most of the 
> cases. However, if you look deeper the code & the specs, they are not 
> really that good. Esp., you will see that the APSIZE register is 
> accessed through 16bit reads/writes, whereas the spec says this is a 8 
> bit register. I have been taught not to write where it is not 
> explicitely allowed to. Moreover, the 'tlbflush' mechanism also writes 
> over reserved bits when using the generic routine. My patch is just a 
> adaptation of what had been done for the Intel 8xx routines (to which I 
> have contributed), so my way is more consistent with what was previously 
> done.
> However, before submitting the patch, I would like to hear from Didier 
> about the X server stuff.
> Does it still hard-locks when you start it ? If testgart works (which 
> seems to be the case... btw, yes the 8MB alloced by the program are 
> normal) and X locks, this would look more like a DRI/X problem (I saw 
> some problems w. Radeon cards on the dri-devel list, which do not seem 
> to be fully solved yet)


No more X hard locks.

Compiled & installed latest CVS X (20011127), which includes a Radeon 
DGA 2.0 patch : everything fine and dandy (except for my 3D performance 
problem).

Kudos to the developer community.


Kind regards,
Didier


Didier Moens
-----
RUG/VIB - Dept. Molecular Biology - Core IT
tel ++32(9)2645309 fax ++32(9)2645348
http://www.dmb.rug.ac.be

