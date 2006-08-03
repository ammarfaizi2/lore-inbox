Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWHCUm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWHCUm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWHCUm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:42:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751322AbWHCUm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:42:56 -0400
Date: Thu, 3 Aug 2006 16:41:35 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Zachary Amsden <zach@vmware.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
Subject: Re: Options depending on STANDALONE
Message-ID: <20060803204135.GH16927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Adrian Bunk <bunk@stusta.de>, Zachary Amsden <zach@vmware.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
	v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org
References: <44D1CC7D.4010600@vmware.com> <1154603822.2965.18.camel@laptopd505.fenrus.org> <44D23B84.6090605@vmware.com> <20060803190327.GA14237@kroah.com> <44D24B31.2080802@vmware.com> <20060803193600.GA14858@kroah.com> <20060803195617.GD16927@redhat.com> <20060803202543.GH25692@stusta.de> <20060803202807.GA7712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803202807.GA7712@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:28:07PM -0700, Greg Kroah-Hartman wrote:
 > On Thu, Aug 03, 2006 at 10:25:43PM +0200, Adrian Bunk wrote:
 > > ACPI_CUSTOM_DSDT seems to be the most interesting case.
 > > It's anyway not usable for distribution kernels, and AFAIR the ACPI 
 > > people prefer to get the kernel working with all original DSDTs
 > > (which usually work with at least one other OS) than letting the people 
 > > workaround the problem by using a custom DSDT.
 > 
 > Not true at all.  For SuSE kernels, we have a patch that lets people
 > load a new DSDT from initramfs due to broken machines requiring a
 > replacement in order to work properly.

Whilst this is a quick fix for users who either know how to hack DSDTs
themselves, or know where to get a fixed one, it doesn't solve the bigger
problem, that the interpretor doesn't get fixed.
And by 'fixed', I mean we aren't bug for bug compatible with that
other OS.  We need to be adding workarounds to the ACPI interpretor
so this stuff 'just works', not hiding from the problem and creating
"but it works in $otherdistro when I do this" scenarios.

		Dave

-- 
http://www.codemonkey.org.uk
