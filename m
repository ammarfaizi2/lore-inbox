Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUIVUaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUIVUaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUIVUaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:30:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:59868 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267365AbUIVU3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:29:53 -0400
Date: Wed, 22 Sep 2004 13:29:05 -0700
From: Greg KH <greg@kroah.com>
To: Vernon Mauery <vernux@us.ibm.com>
Cc: pcihpd <pcihpd-discuss@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <gregkh@us.ibm.com>,
       Pat Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Jess Botts <botts@us.ibm.com>
Subject: Re: [PATCH] acpiphp extension fixes for 2.6.9-rc2
Message-ID: <20040922202905.GB12784@kroah.com>
References: <1087934028.2068.57.camel@bluerat> <200407071147.57604@bilbo.math.uni-mannheim.de> <1089216410.24908.5.camel@bluerat> <200407081209.42927@bilbo.math.uni-mannheim.de> <1089328415.2089.194.camel@bluerat> <20040708232827.GA20755@kroah.com> <1095358993.13519.8.camel@localhost.localdomain> <1095459003.13519.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095459003.13519.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 03:10:03PM -0700, Vernon Mauery wrote:
> On Thu, 2004-09-16 at 11:23, Vernon Mauery wrote:
> > This patch fixes an off by one error that one of the IBM machines that
> 
> I realized today that I had an off by one error myself.  I had one line
> in the wrong place by one (i.e. accessing a pointer into the table after
> calling kfree on the table).  So, please disregard the last patch and
> apply this one instead.
> 
> For the record...
> 
> This patch fixes an off by one error that one of the IBM machines that
> uses the acpiphp_ibm driver.  The slots were numbered starting at 0 in
> BIOS instead of starting at 1 like the pci hotplug subsystem names
> them.  So this patch provides a lookup to translate the Linux slot
> numbers to the internal ACPI numbers.
> 
>  acpiphp_ibm.c |  101 ++++++++++++++++++++++++++++++++++++----------------------
>  1 files changed, 63 insertions(+), 38 deletions(-)
> 
> Signed-off-by: Vernon Mauery <vernux@us.ibm.com>

Applied, thanks.

greg k-h
