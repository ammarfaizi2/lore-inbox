Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWH1Oe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWH1Oe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWH1Oe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:34:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:58679 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751019AbWH1Oe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:34:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uGEVtDw6k5clTTL3yc3jyf31V+ciMb/lWjkGSb8VaxnHa1x469nGXXM726QY27IOvlo+e9bN0ksq7cGSFwFzWVgDc6R5fPJj6QpAVpOt9LHbegtKM53/0gLkk4++kwCcWVMkbvxYKnT2cN33VoiIwdeaoJFbFfU2IAX+Zlm4Jr4=
Message-ID: <44F2FF01.6000103@gmail.com>
Date: Mon, 28 Aug 2006 16:34:18 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Brian D. McGrew" <brian@visionpro.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>
Subject: Re: mounting Floppy and USB - 2.6.16.16
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3B16@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3B16@chicken.machinevisionproducts.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian D. McGrew wrote:
> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com] 
> Sent: Friday, August 25, 2006 9:51 PM
> To: Brian D. McGrew
> Cc: linux-kernel@vger.kernel.org; For users of Fedora Core releases
> Subject: Re: mounting Floppy and USB - 2.6.16.16
> 
> On Fri, Aug 25, 2006 at 02:55:36PM -0700, Brian D. McGrew wrote:
>> Hey Guys:
>>
>> With 2.4.20 and 2.6.9 I had all this automated so everything just
>> happened automatically.  It's not working with 2.6.16.16 now.  What am
> I
>> missing or what did I forget?
> 
> What version of udev and hal are you using?
> 
> What specific errors are you having?
> 
> thanks,
> 
> greg k-h
> -----
> 15_ yum list | grep hal
> hal.i386                                 0.4.7-1.FC3
> installed       
> hal-cups-utils.i386                      0.5.2-8
> installed       
> hal-devel.i386                           0.4.7-1.FC3
> installed       
> hal-gnome.i386                           0.4.7-1.FC3
> installed       
> hal-debuginfo.i386                       0.4.7-1.FC3
> updates-released
> 16_
> 
> 16_ yum list | grep udev
> udev.i386                                039-10.FC3.8
> installed       
> udev-debuginfo.i386                      039-10.FC3.8
> updates-released
> 
> It 'looks' like I have the latest?  I'm not getting any "errors".  But
> with RH7.3/2.4.20 and FC3/2.6.9 inserting a CD or USB Flash drive
> mounted automatically.  I upgraded to 2.6.16.16 on the previously
> working FC3 machines and now it doesn't --- so I'm sure I missing
> something in the kernel configuration and just don't know what it
> is!?!?!

Old udev. That one is the latest in fc3. The latest udev is 098, in rawhide 
there is 095.
Old hal. The latest is 0.5.7.1, in rawhide there is also that version.

Redhat doesn't seem to support old releases too much (fc3 in this case), try to 
upgrade to fc6 test or fc5, or at least
yum --enablerepo=development update hal udev
or something like that.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
