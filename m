Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268107AbUIKLgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268107AbUIKLgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 07:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUIKLgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 07:36:51 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:38924 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S268108AbUIKLf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 07:35:58 -0400
Date: Sat, 11 Sep 2004 12:35:25 +0100
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Tim Hockin <thockin@hockin.org>, Kay Sievers <kay.sievers@vrfy.org>,
       Robert Love <rml@ximian.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040911113525.GA7148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Tim Hockin <thockin@hockin.org>, Kay Sievers <kay.sievers@vrfy.org>,
	Robert Love <rml@ximian.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <1093989924.4815.56.camel@betsy.boston.ximian.com> <20040902083407.GC3191@kroah.com> <1094142321.2284.12.camel@betsy.boston.ximian.com> <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <20040911001849.GA321@hockin.org> <20040911004827.GA8139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911004827.GA8139@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:48:27PM -0700, Greg KH wrote:

 > > What happened to a formatted string argument?  The signal argument can 
 > > become the pre-formatted string, and someone can provide a wrapper
 > > that takes a printf() like format and args.
 > > 	kobject_uevent_printf(kobj, "something bad: 0x%08x", err);
 > 
 > Use an attribute, and have userspace read that formatted argument if
 > need be.  This keeps the kernel interface much simpler, and doesn't
 > allow you to abuse it for things it is not intended for (like error
 > reporting stuff...)

Erm, no. This will just encourage folks to sprintf to a buffer first
and pass the result to kobject_uevent_printf().

nitpick: Also, if this isn't taking formatted input, shouldn't the name of the
function lose the 'f' ?

		Dave

