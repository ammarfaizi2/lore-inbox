Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWCLR7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWCLR7B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 12:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWCLR7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 12:59:01 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:10350 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751560AbWCLR7A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 12:59:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3v0TIOgVa0YjqdK6Ag0q8wMlCc53SXdS+8O7XYdhLa2uSVe1shqYAYX3Jj1n2addoR7v7/5zHJtng/dct9rtJdH9GNPjqIk4jRNfRIh2On2cfdaDRP3cWwF4dHF8U7uUt/o1qZG6UmyRSLusAUzCqBCB84ofZnMLK0OytjIB4M=
Message-ID: <b6c5339f0603120958y7ebc2051q51e24835456d9fcd@mail.gmail.com>
Date: Sun, 12 Mar 2006 12:58:58 -0500
From: "Bob Copeland" <email@bobcopeland.com>
To: "Paul Fulghum" <paulkf@microgate.com>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
Cc: paulus@samba.org, "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1142180789.4360.2.camel@x2.pipehead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <1142011340.3220.4.camel@amdx2.microgate.com>
	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
	 <1142018709.26063.5.camel@amdx2.microgate.com>
	 <20060311150908.GA4872@hash.localnet>
	 <1142099765.3241.3.camel@x2.pipehead.org>
	 <b6c5339f0603111221k2d0afce5hcfd485713ba17338@mail.gmail.com>
	 <1142180789.4360.2.camel@x2.pipehead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/06, Paul Fulghum <paulkf@microgate.com> wrote:
> --- linux-2.6.16-rc5/drivers/usb/class/cdc-acm.c        2006-02-27 09:24:29.000000000 -0600
> +++ b/drivers/usb/class/cdc-acm.c       2006-03-12 10:22:21.000000000 -0600
> @@ -980,7 +980,7 @@ skip_normal_probe:
>         usb_driver_claim_interface(&acm_driver, data_interface, acm);
>
>         usb_get_intf(control_interface);
> -       tty_register_device(acm_tty_driver, minor, &control_interface->dev);
> +       tty_register_device(acm_tty_driver, minor, NULL);
>
>         acm_table[minor] = acm;
>         usb_set_intfdata (intf, acm);
>

Paul,

No oops with the above patch.

thanks!
-Bob
