Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVBQW7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVBQW7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 17:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBQW7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 17:59:15 -0500
Received: from mail.tmr.com ([216.238.38.203]:59141 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261218AbVBQW41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 17:56:27 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and   give
 dev=/dev/hdX as device
Date: Thu, 17 Feb 2005 18:00:56 -0500
Organization: TMR Associates, Inc
Message-ID: <cv36pu$54m$2@gatekeeper.tmr.com>
References: <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com><1108426832.5015.4.camel@bastov> <1108497781.3828.51.camel@crazytrain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1108680318 5270 192.168.12.100 (17 Feb 2005 22:45:18 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <1108497781.3828.51.camel@crazytrain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel wrote:
> On Tue, 2005-02-15 at 14:48, Kiniger, Karl (GE Healthcare) wrote:
> 
>>I can confirm that. Creating a correct  iso image from a CD is a
>>major pain w/o ide-scsi. Depending on what one has done before the iso
>>image is missing some data at the end most of the time.
>>(paired with lots of kernel error messages)
>>
>>Testing was done here using Joerg Schilling's sdd:
>>
>>sdd ivsize=`isosize /dev/cdxxx` if=/dev/cdxxx of=/dev/null \
>>	bs=<several block sizes from 2048 up tried,does not matter>
>>
>>and most of the time it results in bad iso images....

Use isoinfo to get the size in 2k sectors, then
   dd if=/dev/cdrom bs=2k count={size} of=my_file
to pull the image. As noted elsewhere this doesn't work if the image 
isn't iso-9660.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
