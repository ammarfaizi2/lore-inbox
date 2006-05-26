Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWEZLwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWEZLwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWEZLwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:52:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:31305 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932352AbWEZLwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:52:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Gi1tExCdTFpOz6tQb+l7omJScAZlQMZ1SUK+XbpeJjJUCXv2MtfX+TPQ3Z1EVkkzgWTyfRu6zNirISYORWNx/YvEU7ySuycSkrSTaWg8C3/AaZ4t7AbjUVUJh7GVQQ9KEzwxeGsud4TiFyV5wf+O4hJPl/6tHYvgI6q+XJ4WK/o=
Message-ID: <4476EBD7.3060506@gmail.com>
Date: Fri, 26 May 2006 13:51:28 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       st3@riseup.net, linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz> <4476D6EC.4060501@pobox.com> <4476D95B.5030601@gmail.com> <200605261349.56011.mb@bu3sch.de>
In-Reply-To: <200605261349.56011.mb@bu3sch.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Buesch napsal(a):
> On Friday 26 May 2006 12:33, you wrote:
>>>>>> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>>>>>> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
>>>>>> @@ -2131,6 +2131,13 @@ out:
>>>>>>      return err;
>>>>>>  }
>>>>>>
>>>>>> +#ifdef CONFIG_BCM947XX
>>>>>> +static struct pci_device_id bcm43xx_ids[] = {
> 
> Call it
> static struct pci_device_id bcm43xx_47xx_ids[] = {
> please.
> 
> And; _important_; if you submit this change, _also_
> do a patch against the devicescape version of the driver in
> John Linville's wireless-dev tree
> drivers/net/wireless/d80211/bcm43xx
> in the tree at git://kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
Ok, thanks.

- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEduvXMsxVwznUen4RAqQcAJ9j870AGMn5jXW68tEQHZXltAenmQCfX9Ik
oyRfuNnKxGHu8HGVvcDVJHM=
=/NUD
-----END PGP SIGNATURE-----
