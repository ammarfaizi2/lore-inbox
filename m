Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUEFOeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUEFOeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 10:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUEFOeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 10:34:13 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62360 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262370AbUEFOeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 10:34:11 -0400
Date: Thu, 6 May 2004 15:33:21 +0100
From: Dave Jones <davej@redhat.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Small problem, Can anybody help me?
Message-ID: <20040506143321.GA8430@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Srinivas G." <srinivasg@esntechnologies.co.in>,
	linux-kernel@vger.kernel.org
References: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 07:31:56PM +0530, Srinivas G. wrote:

 > I compiled it under same kernel version that is 2.4.18-3. It was showing
 > the following errors.
 > 
 > In file included from hello.c:2:
 > /usr/include/linux/module.h:60: parse error before `atomic_t'
 > /usr/include/linux/module.h:60: warning: no semicolon at end of struct
 > or union
 > /usr/include/linux/module.h:60: warning: no semicolon at end of struct
 > or union
 > /usr/include/linux/module.h:62: parse error before `}'
 > /usr/include/linux/module.h:62: warning: data definition has no type or
 > storage class
 > /usr/include/linux/module.h:91: parse error before `}'

You're trying to include userspace headers into a kernel module.
This won't fly.

 > The errors came due to a mistake in linux header file. Is it so...
 > 
 > Thanks in advance for any help you can come up with.

Last week you claimed "Linux has broken spinlocks", this week "broken includes".
I suggest a trip to http://www.kernelnewbies.org/ may be in order
before you tackle anything more complicated than a helloworld module.

		Dave

