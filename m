Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWIZBMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIZBMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 21:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWIZBMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 21:12:13 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:56043 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S1750803AbWIZBMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 21:12:12 -0400
Message-ID: <45187E63.3020200@metaparadigm.com>
Date: Tue, 26 Sep 2006 09:12:03 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to single_cmd
 mode...
References: <451834D0.40304@goop.org> <20060925202644.GB6278@ucw.cz>
In-Reply-To: <20060925202644.GB6278@ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   
>> I have a ThinkPad X60 which uses the Intel 82801G HDA 
>> audio chip.  This used to work for me, but lately 
>> (sometime during 2.6.18-rcX series) it stopped working - 
>> programs trying to use it tend to just block forever 
>> waiting for /dev/dsp.
>>     
>
> I have x60 here,
>
>   
>> The only obvious symptom is:
>>
>>    hda_intel: azx_get_response timeout, switching to 
>>    single_cmd mode...
>>
>>     

I got similar kernel message relating to an azx_get_response timeout
with an 82801G HDA audio running Debian kernel 2.6.16-2 (happened during
suspend to ram IIRC) - after replacing kernel alsa with alsa-source
1.0.12 (24 Aug release) the problem went away (in addition to making
sound come out when it didn't before).

Not sure if this info helps but trying the alsa-project release and
seeing if that works may help identify what needs fixing in mainline
hda_intel.

~mc
