Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWFBGoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWFBGoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWFBGoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:44:00 -0400
Received: from ns.suse.de ([195.135.220.2]:1241 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751215AbWFBGoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:44:00 -0400
Message-ID: <447FDE2E.5010401@suse.de>
Date: Fri, 02 Jun 2006 08:43:58 +0200
From: Hannes Reinecke <hare@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: "zhao, forrest" <forrest.zhao@intel.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: State of resume for AHCI?
References: <447F23C2.8030802@goop.org> <447F3250.5070101@rtr.ca> <20060601183904.GR4400@suse.de> <447F4BC2.8060808@goop.org> <20060602060323.GS4400@suse.de> <1149228204.13451.8.camel@forrest26.sh.intel.com> <20060602064148.GT4400@suse.de>
In-Reply-To: <20060602064148.GT4400@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Jun 02 2006, zhao, forrest wrote:
>> On Fri, 2006-06-02 at 08:03 +0200, Jens Axboe wrote:
>>> On Thu, Jun 01 2006, Jeremy Fitzhardinge wrote:
>>>> Jens Axboe wrote:
>>>>> It's a lot more complicated than that, I'm afraid. ahci doesn't even
>>>>> have the resume/suspend methods defined, plus it needs more work than
>>>>> piix on resume.
>>>>>  
>>>> Hannes Reinecke's patch implements those functions, basically by 
>>>> factoring out the shutdown and init code and calling them at 
>>>> suspend/resume time as well.
>>>>
>>>> Is that correct/sufficient?  Or should something else be happening?
>>> No that's it, I know for a fact that suspend/resume works perfectly with
>>> the 10.1 suse kernel. You can give that a shot, if you want.
>> You may mean the Hannes's patch for 10.1 SUSE kernel. Hannes's patch
>> posted in open source community(or in linux-ide mailing list) didn't
>> work.
> 
> I didn't say Hannes patch, I said I know that 10.1 works. And that is
> probably in large due to the patch that Hannes did, which implents
> resume/suspend and takes care of reinitializing the resources.
> 
Indeed. I didn't post the latest set of patches to the open-source
community as Jeff indicated he would only accept patches against
libata-dev. And as I didn't have time to port them yet I didn't feel the
need to do so.

Forrest, please drop me a mail if I can be of further assistance.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux Products GmbH		S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
