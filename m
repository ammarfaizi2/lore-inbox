Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWIPAXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWIPAXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWIPAXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:23:30 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:25606 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932249AbWIPAXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:23:30 -0400
Date: Sat, 16 Sep 2006 02:23:27 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Message-ID: <20060916002326.GA69619@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net> <20060915154752.d7bdb8a0.rdunlap@xenotime.net> <20060915164135.34adb303.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915164135.34adb303.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 04:41:35PM -0700, Andrew Morton wrote:
> I'd want to be hearing from distro people on that - I'd expect that the
> .config which is used to build configs.ko would not differ from that which
> is used to build vmlinux.

What's the point though?  If you can find configs.ko, you can have
install_modules copy config.gz there, no?  And you also have it in
/boot/config-`uname -r`.  /proc/config.gz has a trust value only
because it is linked into the image.  Having it as a module gives the
exact save level of trustyness that the perfectly well working
solution of copying in /boot had before.

In other terms, if you allow configs.ko, you can't trust the contents
of /proc/config.gz anymore and /proc/config.gz lost all its interest
where it comes to debugging.

  OG.

