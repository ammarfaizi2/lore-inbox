Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVCNBIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVCNBIk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 20:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVCNBIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 20:08:40 -0500
Received: from 83-216-143-24.alista342.adsl.metronet.co.uk ([83.216.143.24]:33286
	"EHLO devzero.co.uk") by vger.kernel.org with ESMTP id S261615AbVCNBIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 20:08:37 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org,
       Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Date: Mon, 14 Mar 2005 01:03:55 +0000
User-Agent: KMail/1.8
References: <87u0ng90mo.fsf@stark.xeocode.com> <200503130152.52342.pmcfarland@downeast.net> <874qff89ob.fsf@stark.xeocode.com>
In-Reply-To: <874qff89ob.fsf@stark.xeocode.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503140103.55354.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 March 2005 22:26, you wrote:
> Patrick McFarland <pmcfarland@downeast.net> writes:
> > On Saturday 12 March 2005 01:31 pm, Greg Stark wrote:
> > > OSS Audio doesn't work properly for Quake3 in 2.6.10 but it worked in
> > > 2.6.6. In fact I have the same problems in 2.6.9-rc1 so I assume 2.6.9
> > > is affected as well. This is with the Intel i810 drivers.
> >
> > Why are you not using ALSA?
>
> Well frankly because whenever I tried it it didn't work. The i810 drivers
> were *completely* broken in the 2.6 kernel I original installed, 2.6.5 I
> think.
>
> In any case I understood that Quake doesn't work with alsa drivers because
> it depends on mmapped output which they don't support at all. Or something
> like that. I gave up on them when I found OSS worked reliably.

Quake3's doing something strange with the OSS devices. You can work around it 
in ALSA's OSS emulation by disabling the record features for the quake3.x86 
binary, and it should all work fine.

echo "quake3.x86 0 0 direct" > /proc/asound/card0/pcm0p/oss
echo "quake3.x86 0 0 disable" > /proc/asound/card0/pcm0c/oss

(I gleamed the above from google.com, you might need to modify it slightly).

The intel8x0 driver is probably one of the most widely used ALSA drivers, so 
I'd hope it wasn't broken! My laptop uses the driver, it is superb.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
