Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTGFTun (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 15:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTGFTun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 15:50:43 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:20121 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263315AbTGFTum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 15:50:42 -0400
Message-ID: <3F0880FC.1050101@rackable.com>
Date: Sun, 06 Jul 2003 13:05:16 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: imunity@softhome.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel Compiling using "make rpm" question PLEASE!!
References: <courier.3F073637.000070EE@softhome.net>
In-Reply-To: <courier.3F073637.000070EE@softhome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jul 2003 20:05:14.0221 (UTC) FILETIME=[E9A331D0:01C343F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imunity@softhome.net wrote:

>
> Still trying to figure out how to use "rpmbuild -bb"


  What you need for that is a rpm spec file.  Grab a kernel.src.rpm from 
a distribution.  Install it, and cd to /us/src/redhat (other distros may 
have a different name in /usr./src).  Now the sources, and patches 
should be in SOURCE, and the spec file in SPEC.   Now you can modify/add 
the source/patches, and the spec. To create rpms you run "rpm -bb <spec 
file>".  Of course to get the i686 rpms you want you need to add 
"--target i686".

  Keep in mind this involves a lot of rpm spec file black magic.  Also 
most of time you will end up with at least 3 kernel rpms via this 
method.  You really don't want to do this unless you need to roll your 
own custom releases of a distro for some reason.

