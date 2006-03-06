Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWCFRAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWCFRAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCFRAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:00:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:967 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751273AbWCFRAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:00:47 -0500
Date: Mon, 6 Mar 2006 09:00:05 -0800
From: Paul Jackson <pj@sgi.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: jesper.juhl@gmail.com, arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Is that an acceptable interface change?
Message-Id: <20060306090005.e5575140.pj@sgi.com>
In-Reply-To: <20060306161512.GB23513@dspnet.fr.eu.org>
References: <20060306011757.GA21649@dspnet.fr.eu.org>
	<1141631568.4084.2.camel@laptopd505.fenrus.org>
	<20060306155021.GA23513@dspnet.fr.eu.org>
	<9a8748490603060755r55b3584bpf0a16451a57925b5@mail.gmail.com>
	<20060306161512.GB23513@dspnet.fr.eu.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please excuse me if I'm a little dense here, but the kernel headers
> _define_ the userspace-kernel interface. 

I don't think so.  The kernel headers define the API's that the
various kernel facilities present to each other, within the kernel.

The userspace-kernel interface is not really a simple interface
of procedures and types definable by a traditional C header.
It uses a variety of techniques, such as special calling conventions,
special files, and what not ... almost everything possible except
the simple call by one procedure of another on a common stack.

In the general case, we can do no more than document, from the
kernel side, what is the interface, and expect libraries and such
on the user side to wrap this up in a form palatable to C (and
other diverse) language uses.

Such header files as are useful to a userspace C programmer are
usually provided by the userspace library, for it is that library
that the application is linking with, not the kernel.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
