Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVC3MBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVC3MBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 07:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVC3MBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 07:01:12 -0500
Received: from viking.sophos.com ([194.203.134.132]:49415 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S261847AbVC3MBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 07:01:07 -0500
MIME-Version: 1.0
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 30/03/2005 13:00:56,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 30/03/2005 13:00:56,
	Serialize complete at 30/03/2005 13:00:56,
	S/MIME Sign failed at 30/03/2005 13:00:56: The cryptographic key was not
 found,
	S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12
  |February 13, 2003) at 30/03/2005 13:01:00,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 5.0.12  |February
 13, 2003) at 30/03/2005 13:01:00,
	Serialize complete at 30/03/2005 13:01:00,
	S/MIME Sign failed at 30/03/2005 13:01:00: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.2|June 01, 2004) at
 30/03/2005 13:01:06,
	Serialize complete at 30/03/2005 13:01:06
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Davide Rossetti <davide.rossetti@roma1.infn.it>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>
Subject: Re: Delay in a tasklet.
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFCB9EC071.D1079395-ON80256FD4.0041A4A7-80256FD4.004202B6@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 30 Mar 2005 13:01:00 +0100
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2005 12:50:01 linux-kernel-owner wrote:

>> I'd be interested in the answer as well. I have a driver which does
>> udelay(100), so no 1000 but anyway, and of course I end up having the 
X86_64
>> kernel happily crying. I'm moving to a little state-machine to allow 
for a
>> multi-pass approach instead of busy-polling..
>> regards
>
>schedule_timeout() would come to mind.

Not from a tasklet. ;)

I had a custom primitive some time ago which I imaginatively named 
taskletex. When scheduling a tasklet one could then specifiy a delay in 
jiffies. If zero, a normal tasklet would be scheduled and if >0 a timer 
would be added. Nothing fancy or special really, but it was useful for the 
work I was doing at that time.


