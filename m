Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264515AbSIQTqB>; Tue, 17 Sep 2002 15:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264543AbSIQTqB>; Tue, 17 Sep 2002 15:46:01 -0400
Received: from ns1.cypress.com ([157.95.67.4]:61838 "EHLO ns1.cypress.com")
	by vger.kernel.org with ESMTP id <S264515AbSIQTqA>;
	Tue, 17 Sep 2002 15:46:00 -0400
Message-ID: <3D878788.2030603@cypress.com>
Date: Tue, 17 Sep 2002 14:50:32 -0500
From: Thomas Dodd <ted@cypress.com>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: Problems accessing USB Mass Storage
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark C. Wrote:
 >>> [root@stimpy dev]# dd if=/dev/sda of=/dev/null bs=1k count=1
 >>> dd: reading `/dev/sda': Input/output error
 >>> 0+0 records in
 >>> 0+0 records out


Randy.Dunlap wrote:
> On Tue, 17 Sep 2002, Jonathan Corbet wrote:
> 
> |
> | You might try just using dd to copy your card to disk with an offset of 25
> | sectors, and see of you can mount the resulting image.
> 
> This is a bit like what we (JE, David Brownell, and I) saw at
> the USB plugfest in 1999.  We had a camera device that we
> couldn't mount as a filesystem, but we could dd it.
> When we did that and studied the dd-ed file, we could see a
> FAT filesystem beginning after the first <N> blocks (but more than
> 25 sectors IIRC -- more like after 50-100 KB, or maybe even more).

See the above form Mark's post. He tried to dd a 1K block
and it failed. Granted, The first few blocks may need to be skipped,
but right now he cannot even get the raw data out.

If we can get the data, we can use the loop device to mount it.

Any ideas to figure out the why the dd fails?

	-Thomas


