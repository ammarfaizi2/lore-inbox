Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWEFB5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWEFB5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 21:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWEFB5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 21:57:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:7001 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWEFB5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 21:57:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a95GHKYhSVNsF+aM7oMWrl5+4/3ZgI97XFZ8onLynNkvEBWugDMAMPjBZLgy743IkqpeounOarjg8bjNn+JspnqPraFL2NYpwBlUz+84QAoTQwhohvrS0BpVpg16RoZT1DHPdcudc0aGcz3GC9SGfbcnDs7etd/v7pBHnd+NJCw=
Message-ID: <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
Date: Sat, 6 May 2006 11:57:12 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: "Greg KH" <greg@kroah.com>, "Ian Romanick" <idr@us.ibm.com>,
       "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	 <1146784923.4581.3.camel@localhost.localdomain>
	 <445BA584.40309@us.ibm.com>
	 <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	 <20060505202603.GB6413@kroah.com>
	 <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	 <20060505210614.GB7365@kroah.com>
	 <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	 <20060505222738.GA8985@kroah.com>
	 <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has everything to do with the 'enable' file. The 'enable' file lets
> you change the state of the hardware without an ownership mechanism.
> Other device users will not be notified of the state change. Since the
> other users can't be sure of the state of the hardware when they are
> activated, they will have to reload their state into the hardware on
> every activation.

Jon

you seem to miss the fact that this can be done now without the enable
flag, setpci can be used to disable the BARs, again the enable flag
doesn't change that....

Dave.
