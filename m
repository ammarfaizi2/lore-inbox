Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWD0LEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWD0LEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWD0LEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:04:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50656 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932469AbWD0LEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:04:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Simple header cleanups
Date: Thu, 27 Apr 2006 13:03:52 +0200
User-Agent: KMail/1.9.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> <200604271010.06711.vda@ilport.com.ua> <m3fyjze72x.fsf@defiant.localdomain>
In-Reply-To: <m3fyjze72x.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604271303.52617.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 10:49, Krzysztof Halasa wrote:
> We _do_ have a stable userspace ABI and API, and contrary to the popular
> belief the header set would be quite small (probably an order of magnitude
> smaller than the "sanitized headers" package). What we need to export is
> the actual API (including things like ioctl, netlink, SG_IO etc), most
> things should be kept private to the kernel (and never copied anywhere
> etc).

Yes, that is also what the 'make headers_install' target in David's tree
does (not the one proposed for inclusion here). It installs only headers
that are meaningful to glibc and the few other traditional users and strips
out the parts that are not inside __KERNEL__.

	Arnd <><
