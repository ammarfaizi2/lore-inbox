Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbRERRLs>; Fri, 18 May 2001 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261213AbRERRLi>; Fri, 18 May 2001 13:11:38 -0400
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:17067 "EHLO
	fw-cam.cambridge.arm.com") by vger.kernel.org with ESMTP
	id <S261198AbRERRL0>; Fri, 18 May 2001 13:11:26 -0400
Message-Id: <4.3.2.7.2.20010518175230.0253e040@cam-pop.cambridge.arm.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 18 May 2001 18:10:20 +0100
To: <linux-kernel@vger.kernel.org>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@arm.com>
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <d33da9tjjw.fsf@lxplus015.cern.ch>
In-Reply-To: <"Eric S. Raymond"'s message of "Sat, 5 May 2001 19:27:31 -0400">
 <20010505192731.A2374@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:22 PM 5/13/01 +0200, you wrote:
>I've said before on these lists that one of the purposes of
>CML2's single-apex tree design is to move the configuration
>dialog away from low-level platform- specific questions towards
>higher-level questions about policy or intentions.
>
>Or to put another way: away from hardware, towards capabilities.

Can I just say I think this is the right approach, overall. Those who say 
it's not right to cripple those doing weird things to support the masses 
are right, but on the other hand very many kernel compiles will be 
relatively small deviations from a fairly standard setup (e.g. enabling or 
disabling NAT) and in my opinion life's too short to spend learning about 
configuring the latest kernel.

Specifically:

1. Deriving common cases from simple assertions is Good for many people, 
making it less likely they will end up with a bad kernel through oversight.

2. Allowing an expert mode that allows you to change each & every option 
allows those with specific needs to configure them (i.e. you need know 
whether a user made a choice to include X rather than it being a 
derivation, and this must be stored in the config database along with the 
actual choice)

3. I would like to be able to start off configuring a kernel with a list of 
statements like:

  - an Asus motherboard
  - a Pentium III
  - an Adaptec AHA2400 SCSI controller
  - IDE disks

and see what else must be specified. I.e. I don't want to have to search to 
tell the config program what I know; I want to tell it what I know, digest 
that and then let it figure out what else it needs answers to.

-- extra bonus section: Obviously, sometimes, you are compiling for another 
machine, but it would be great if the config could be asked to get at least 
some of this list of items from the current hardware/system (using lspci 
and friends).

It would be nice if it then printed a summary (in English, not config-ese) 
what has been configured, so I can double-check.

4. It would be neat to have a quick way of taking a config file from an 
older kernel. Then the config program to be able to tell what config items 
have changed/are new/etc and then have a menu containing just these items. 
You could then upgrade kernels by looking through this list, safe in the 
knowledge that everything else is already OK.

5. One final, general plea: Please can we have a sensible menu structure 
for the config options. The current (for me, 2.4.1) menu structure is just 
plain irritating, because it is not organised in an understandable (for me) 
way...  If you want me to help define things further, I'm willing.

HTH,

Ruth
-- 

Ruth 
Ivimey-Cook                       ruthc@sharra.demon.co.uk
Technical 
Author, ARM Ltd              ruth.ivimey-cook@arm.com

