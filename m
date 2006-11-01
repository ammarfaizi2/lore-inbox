Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992624AbWKAQ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992624AbWKAQ0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992628AbWKAQ0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:26:18 -0500
Received: from nz-out-0102.google.com ([64.233.162.195]:45842 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S2992624AbWKAQ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:26:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=iM8TdQmHlgtBYwmY9aF56ePnbfsaMHh4fVMs2zoWyguBYvR4+vtSkDt660GQXnIPt5qzJZXphqvgV57UafEwWTQ8mIRJaNJw1I6ogvzaD8fyc6iE/0BIKzx/aa+yDIix5A4hMKc+mwCMB6da6JB+NjyJuFnC/TVgV/nvfVTtpM0=
Reply-To: andrew.j.wade@gmail.com
To: andrew.j.wade@gmail.com
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Date: Wed, 1 Nov 2006 11:25:56 -0500
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <20061031042032.GA12729@kroah.com> <200610310010.09759.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200610310010.09759.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611011126.02648.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 00:09, Andrew James Wade wrote:
> On Monday 30 October 2006 23:20, Greg KH wrote:
> > On Mon, Oct 30, 2006 at 08:11:23PM -0800, Andrew Morton wrote:
> > > On Mon, 30 Oct 2006 22:58:11 -0500
> > > Andrew James Wade <andrew.j.wade@gmail.com> wrote:
> > > 
> > > > I've just found out that unsetting CONFIG_SYSFS_DEPRECATED makes the
> > > > crash go away.
> > > 
> > > How bizarre.  sysfs changes cause unexpected pte protection values?
> 
> Perhaps one of the drivers is responding badly to device_create
> failing? (-EEXIST, if I'm not mistaken). 
> 
> > 
> > That's just wrong.  Something odd is happening here.  Can you try to
> > bisect things to determine the patch that is causing the problem?
> 
> Sure. 

driver-core-fixes-sysfs_create_link-retval-checks-in.patch is where
this particular crash starts.

Andrew Wade
