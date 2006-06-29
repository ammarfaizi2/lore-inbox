Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWF2UqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWF2UqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWF2UqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:46:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8407 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932467AbWF2UqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:46:20 -0400
Date: Thu, 29 Jun 2006 16:45:27 -0400
From: Dave Jones <davej@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <greg@kroah.com>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060629204527.GD13619@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wedgwood <cw@f00f.org>, Greg KH <greg@kroah.com>,
	gregkh@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200606291801.k5TI12br003227@hera.kernel.org> <20060629204206.GA3010@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629204206.GA3010@tuatara.stupidest.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 01:42:06PM -0700, Chris Wedgwood wrote:
 > what am i missing here?
 > 
 > > --- a/arch/i386/Kconfig
 > > +++ b/arch/i386/Kconfig
 > > @@ -529,6 +529,7 @@ config X86_PAE
 > >  	bool
 > >  	depends on HIGHMEM64G
 > >  	default y
 > > +	select RESOURCES_64BIT
 > >  
 > >  # Common NUMA Features
 > >  config NUMA
 > 
 > this isn't a similar option for x86_64, so...


+config RESOURCES_64BIT
+       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
+       default 64BIT
+       help
+         This option allows memory and IO resources to be 64 bit.


		Dave

-- 
http://www.codemonkey.org.uk
