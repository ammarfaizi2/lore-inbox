Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUJMAvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUJMAvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUJMAvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:51:45 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:2981 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S268122AbUJMAvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:51:44 -0400
Message-ID: <004a01c4b0be$c33a28e0$03c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Pete Zaitcev" <zaitcev@redhat.com>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20041005124914.GA1009@gondor.apana.org.au> <20041011172147.GA3066@logos.cnet> <20041012212153.GA24663@gondor.apana.org.au> <20041012152343.5b70cbd3@lembas.zaitcev.lan> <20041012231446.GA25318@gondor.apana.org.au>
Subject: Re: [linux-usb-devel] Re: [HID] Fix hiddev devfs oops
Date: Tue, 12 Oct 2004 20:51:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Tue, Oct 12, 2004 at 03:23:43PM -0700, Pete Zaitcev wrote:
>>
>> Herbert, I'm sorry for the wait. Marcelo asked me to take care of
>> this, but I kept postponing it because I wanted to look closer, and
>> this and that... It looks entirely reasonable and my hid devices
>> continue to work, but I haven't tested hiddev (UPS or something ?).
>
> Yes that's exactly the situation I'm in (APC UPS via USB) and it does
> fix the OOPS for me when hid is unloaded with the UPS connected.

Another scenario to keep in mind is unplugging a USB device while a process 
still has its corresponding hiddev node open. I fixed that issue in 2.6 a 
while ago. I'm not sure if 2.4 is susceptible. It may or may not be 
orthogonal to the problem your patch addresses.

--Adam

