Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWHNQ7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWHNQ7m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHNQ7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:59:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:53276 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932415AbWHNQ7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:59:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZWNDCXAraYRQhsVh3eWK9Q5ByJeSs8hbUcQBAa4rf9zPLHDMRqsw/Yd0vMiQ1M/5ZzKStnO1r/vl8mvQQogUwlVOfyMv12BBka4fTHcb0oYB6THBnFfICRiNu8flckVBtQbDXUqVw/lT/TvkYIwx0kVq9vGYgA2/ENK2LNXNzIc=
Message-ID: <d120d5000608140959i5a4edd6byefe8259e688239e2@mail.gmail.com>
Date: Mon, 14 Aug 2006 12:59:38 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Gene Heskett" <gene.heskett@verizon.net>
Subject: Re: Touchpad problems with latest kernels
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608141233.41044.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <200608141134.32714.gene.heskett@verizon.net>
	 <d120d5000608140853t5a27b522ra7b29aeb0e318efa@mail.gmail.com>
	 <200608141233.41044.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Gene Heskett <gene.heskett@verizon.net> wrote:
> >
> >serioX is the name of serio port your touchpad is connected to
> >(serio0, serio1, etc) You will have to look which port is bound to
> >psmouse driver.
>
> What if there appear to be two functional mice running the same curser?
> One being the M$ accessory mouse, the other the touchpad.  So I would have
> a serio0 and a serio1.  How do I determine which to feed those commands
> to?  Is the device identified in those info trees?
>

It depends... One serio is your keyboard port, another one is aux
(mouse). The external mouse - is it also PS/2 or is is USB? If it is
USB then it won't be listed under serio bus but rather in USB bus...
Look at /sys/bus/serio/devices/serioX/inputX/name attribute in sysfs -
it should give you a clue what device is connjected to a serio port.


-- 
Dmitry
