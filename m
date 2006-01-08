Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161173AbWAHKbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbWAHKbK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWAHKbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:31:10 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:14820 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S1161173AbWAHKbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:31:09 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: sanitized kernel headers
Date: Sun, 8 Jan 2006 10:31:02 +0000
User-Agent: KMail/1.8.2
References: <43BF9114.7040102@gmail.com>
In-Reply-To: <43BF9114.7040102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081031.02563.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2006 09:59, Alexander E. Patrakov wrote:
>
> What is the recommended (non-dead) alternative implementation of such
> "sanitized" headers? Where is the roadmap for this area?

I still don't buy the arguments of the kernel maintainers who shun 
responsibility for this. My undoubtedly naive position is that

1) The kernel does a load of really clever low level stuff, and presents a 
stable API that the rest of the world (userspace) can use

2) Every part of that API that userspace needs should be presented to 
userspace in a consistent and reliably useable way

3) Any part of the kernel to which userspace absolutely needs access _must_ be 
part of that consistently and reliably presented API.

This 'sanitized kernel headers' mess (the single biggest _PITA_ for all small 
independent  linux distro creators/maintainers) should either

1) be unnecessary
2) be included as part of the kernel sources and acknowledged as specifically 
for use by userspace

Currently affected userspace packages include stuff like glibc, directfb, 
netfilter, iproute2, alsa, iputils, pcmcia-cs, udev and wireless-tools.

Andrew Walrond
[thumbs nose, dons hardhat, dives into hastily prepared bunker]
