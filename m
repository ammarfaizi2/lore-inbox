Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSIZAGm>; Wed, 25 Sep 2002 20:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSIZAGm>; Wed, 25 Sep 2002 20:06:42 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:55005 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261228AbSIZAGk>; Wed, 25 Sep 2002 20:06:40 -0400
Date: Wed, 25 Sep 2002 17:11:57 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and
 usb
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D9250CD.7090409@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020925212955.GA32487@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	/* stuff we want to pass to /sbin/hotplug */
> +	envp[i++] = scratch;
> +	scratch += sprintf (scratch, "PCI_CLASS=%04X", pdev->class) + 1;
> +
> +	envp[i++] = scratch;
> +	scratch += sprintf (scratch, "PCI_ID=%04X:%04X",
> +			    pdev->vendor, pdev->device) + 1;

And so forth.  Use "snprintf" and prevent overrunning those buffers...

- Dave


