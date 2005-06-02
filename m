Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFBI5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFBI5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFBI5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:57:19 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:59219 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261277AbVFBIly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:41:54 -0400
Message-ID: <429EC63F.5070804@smallworld.cx>
Date: Thu, 02 Jun 2005 09:41:35 +0100
From: Ian Leonard <ian@smallworld.cx>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: 2.4.30 - USB serial problem
References: <mailman.1117130162.21749.linux-kernel2news@redhat.com> <20050531184048.5ef9fd44.zaitcev@redhat.com>
In-Reply-To: <20050531184048.5ef9fd44.zaitcev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Thu, 26 May 2005 18:52:10 +0100, Ian Leonard <ian@smallworld.cx> wrote:
> 
> 
>>We recently upgraded from 2.4.24 to 2.4.28 and the problem described 
>>below appeared. I have tested it on 2.4.30 and the fault still exists.
>>[...]
>>Examining the packet that caused the problem showed it was very similar 
>>to the others but it contained 0x0a. This obviously stuck out as being a 
>>candidate for some sort of translation problem.
> 
> 
> The above looks almost too obvious but for this:
> 
> 
>>I also built a 2.4.28 kernel with the ftdi_sio and usbserial code from 
>>the 2.4.24 release. It also failed. This was a surprise and I am 
>>wondering of I did it correctly.
> 
> 
> Did you nail down a scenario which we can debug? Frankly it's not credible

Not as yet. As I indicated I can only test the problem at a remote site 
and I don't get much time to look at it.

> that transplanted usbserial and ftsi_sio would fail to work. I know that

I agree, it can't be the case. To prove that I hadn't just made a 
mistake, I transplanted the whole usb branch and it still failed. This 
really points to the user app - which is complex and I haven't got to 
the bottom of it. It's a multi-threaded library and I see it's doing 
some sort of packet requeuing based on a timer. I can't see what has 
changed but I am guessing it's a kernel timing issue. It would explain 
everything.

> I changed quite a bit between 2.4.24 and 2.4.28, but your experiment
> undoes that.

I think the usb is red herring - sorry about that. BTW, I see you have 
cc'd Ian (hi Ian). By coincidence we are using an MEV usb device.


-- 
Ian Leonard

Please ignore spelling and punctuation - I did.
