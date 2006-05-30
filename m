Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWE3WxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWE3WxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWE3WxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:53:16 -0400
Received: from mail.visionpro.com ([63.91.95.13]:57873 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S932534AbWE3WxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:53:15 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Sharing memory between kernel and user space
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 30 May 2006 15:53:14 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B331D@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Sharing memory between kernel and user space
Thread-Index: AcaEO0EWI7vDXMIcR++YZH69iyZhZwAAIK4g
From: "Brian D. McGrew" <brian@visionpro.com>
To: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the 2.6.16.16 kernel.  Is there any chance that I could
trouble you for a snippet of code to do that?  I've tried every
combination I can think of.

Thank you,

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of H. Peter Anvin
Sent: Tuesday, May 30, 2006 3:46 PM
To: linux-kernel@vger.kernel.org
Subject: Re: Sharing memory between kernel and user space

Followup to:
<14CFC56C96D8554AA0B8969DB825FEA0012B331A@chicken.machinevisionproducts.
com>
By author:    "Brian D. McGrew" <brian@visionpro.com>
In newsgroup: linux.dev.kernel
>
> I have a question about the best way to share memory between user and
> kernel space.
> 

In general, allocate the memory in kernel space (via get_free_page et
al), and make accessible to userspace via mmap on a device node.

	-hpa
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
