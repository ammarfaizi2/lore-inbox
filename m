Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWGCGve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWGCGve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWGCGve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:51:34 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:54619 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750833AbWGCGve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:51:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aJc+lcsU7hAAHZh0XwFDCJ2V6QvMs2gO/WtD87cx2BFLgXwV3qVfmcVtQ/z1/NM4DuNvx+1VfmBZEiZ2NqwDKwnikAJl/a6pkXAtgDFn4CxJZ8ZDxRzhIinnoC/YRqK12syqrTj/EQI5yqPooLLKUK0ItkWavneYpnxq9YJcdT4=
Message-ID: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
Date: Mon, 3 Jul 2006 02:51:33 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Driver for Microsoft USB Fingerprint Reader
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

I would like to develop a driver for any kind of fingerprint reader
that currently doesn't have a driver for linux, and I'm open for
suggestions on which device I should use. My first thought was the
microsoft usb fingerprint reader
(http://www.geeks.com/details.asp?invtid=DG2-00002-DT&cpc=SCH) because
it's a new device (and, of course, doesn't have any driver for linux),
it's cheap, and it's from MS (read "would be fun" =)

Before proceeding, I would like to know if:
1) Would it be ilegal to write a driver for such device (i.e., without
the permition of the hardware manufacturer) ?

2) Is there any standard on how the fingerprint should be presented to
userspace ? Currently the only fingerprint driver that I could find is
the Siemens ID Mouse driver (drivers/usb/misc/idmouse.c), and it
delivers the fingerprint as an image in pnm format thru a device like
/dev/idmouse0 (cat /dev/idmouse 0 > /tmp/fingerprint.pnm). Is this the
best way to deliver the image to userspace, or should we have an
centralized for that, or a centralized device like /dev/fingerprint0
(which then wraps to the idmouse driver or any other)

There are also other interesting devices like this
(http://www.geeks.com/details.asp?invtid=FIN002&cpc=SCH) that are
cheap and probably would be a better subject. I know that there are
some standards (something related to the resolution of the readers),
and some of the cheap ones don't meet some "high-profile security"
standards (I think from NSA or something like that). Maybe we should
also try any of those heavy-duty high-security gadgets too.

Another question: Is there any place (probably a webpage) where we can
see a list of hardware devices separated by category, and know if
there's already a driver for it (and the name/url of the maintainer)
or not, if there are plans to develop a driver for it or not, or to
form teams to develop it ? Like a webpage where I can browse and see
that the device X doesn't have any drivers for it (and people can go
and "vote" for a driver, so we can know which devices are most wanted
by users), and sign ourselves to develop it ? I think that it would be
cool. If there isn't anything like that, I can develop it myself and
somebody at kernel.org or another place could host it =]

Thanks,
Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
