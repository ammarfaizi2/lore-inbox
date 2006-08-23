Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWHWD7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWHWD7R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 23:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWHWD7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 23:59:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:57393 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932347AbWHWD7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 23:59:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kmJLHTWcMtXuSWMuOQxpggjuLGP1kDhvgurGK4J/KDMZWsqMK+5AxMOYlxc7qfWbIYV+8Vkx25+ZBqdeuXKyFizjFZdQ+UYHNkXY7QFdQxj1tgB5sTbB4H+JGuqEVz0u5kkjI5FvfY+Yw4GAvv1klAuprJxrWAUP1hzyKmBliMk=
Message-ID: <ec7cefb0608222059g48c36384keefedf8e19771cb7@mail.gmail.com>
Date: Tue, 22 Aug 2006 20:59:14 -0700
From: "Eric Brower" <ebrower@gmail.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: sym53c8xx PCI card broken in 2.6.18
Cc: "David Miller" <davem@davemloft.net>
In-Reply-To: <200608222339.43511.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608221546.11532.dj@david-web.co.uk>
	 <20060822.133901.110902970.davem@davemloft.net>
	 <200608222339.43511.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, David Johnson <dj@david-web.co.uk> wrote:
> On Tuesday 22 August 2006 21:39, you wrote:
> > Sounds like the interrupts are being misconfigured for the
> > PCI card.  Please post 2 pieces of information:
> >
> > 1) Boot logs with "ofdebug=2" given on the kernel command line

The envctrl OOPS is definately my fault in the blind conversion of the
driver to the OF interface-- of_find_propery() return values should be
checked for NULL rather than relying upon a -1 value stored into lenp.
 We can discuss this separately, since you are using an out-of-kernel
driver.

Thanks,
E


> > 2) Output of "/usr/sbin/prtconf -pv"
> >
>
> Both attached.
>
> Now that I've let the system finish booting, there are also a few oopses that
> seem related to the new openprom interface.
>
> Regards,
> David.
>
> --
> David Johnson
> www.david-web.co.uk - My Personal Website
> www.penguincomputing.co.uk - Need a Web Developer?
>
>
>


-- 
E
