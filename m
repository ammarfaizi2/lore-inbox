Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290943AbSAaFdS>; Thu, 31 Jan 2002 00:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290940AbSAaFdI>; Thu, 31 Jan 2002 00:33:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:39431 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S290946AbSAaFcr>;
	Thu, 31 Jan 2002 00:32:47 -0500
Date: Wed, 30 Jan 2002 21:31:24 -0800
From: Greg KH <greg@kroah.com>
To: Mark McClelland <mark@alpha.dyndns.org>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: ov511 verbose startup.
Message-ID: <20020131053124.GI31006@kroah.com>
In-Reply-To: <20020131023457.D31313@suse.de> <20020131035936.GD31006@kroah.com> <3C58D69B.6000205@alpha.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C58D69B.6000205@alpha.dyndns.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 03 Jan 2002 01:45:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:31:07PM -0800, Mark McClelland wrote:
> 
> Greg (if you know): usbfs is not allowed to access claimed interfaces, 
> correct? (ie. ones that are implicitly claimed because of a successful 
> return from probe()). Are interfaces treated as claimed while probe() is 
> active, so that user-space "probes" cannot interfere with driver probes()?

Yes, but odds are, it is trying to read the configuration of the device,
and we don't have control pipe locking, yet :)

Dave, does this problem go away on 2.5.3-pre6?
And which host controller driver are you using?

thanks,

greg k-h
