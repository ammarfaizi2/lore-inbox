Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVAGTZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVAGTZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVAGTYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:24:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2238 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261556AbVAGTWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:22:10 -0500
Date: Fri, 7 Jan 2005 11:21:58 -0800
From: Greg KH <greg@kroah.com>
To: Mark_H_Johnson@Raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm1
Message-ID: <20050107192158.GA30096@kroah.com>
References: <OF4C49B1DD.0FAC66D2-ON86256F81.0059D64B@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF4C49B1DD.0FAC66D2-ON86256F81.0059D64B@raytheon.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 10:32:31AM -0600, Mark_H_Johnson@Raytheon.com wrote:
> After booting with 2.6.10-mm1, I get the following message on the serial
> console (last message seen):
> 
> PCI: 0000:00:0b.0 has unsupported PM cap regs version (1)
> 
> For reference, lspci shows that device is
> 00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
> 
> I notice there is a relatively recent patch to add this message.
>   http://article.gmane.org/gmane.linux.kernel/263974
> 
> However, my .config includes
> 
> #
> # Power management options (ACPI, APM)
> #
> # CONFIG_PM is not set
> 
> which should disable all power management related processing.
> 
> [1] Should the code generating the warning be active without CONFIG_PM
> being set?
> 
> [2] Can you explain why the message is generated (why not silently ignore
> the older hardware) or is there something in an init script (I am using
> Fedora Core 2) that [incorrectly] assumes power management is available to
> cause the message to be printed?

David, any ideas?  Should I just revert this change for now?

thanks,

greg k-h
