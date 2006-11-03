Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753488AbWKCUAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbWKCUAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753518AbWKCUAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:00:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:62948 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753488AbWKCUAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:00:14 -0500
Date: Fri, 3 Nov 2006 14:00:11 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: 20060906182719.GB24670@sergelap.austin.ibm.com
Cc: serue@us.ibm.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061103200011.GA2206@sergelap.austin.ibm.com>
References: <20061103175730.87f55ff8.chris@friedhoff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103175730.87f55ff8.chris@friedhoff.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting chris friedhoff (chris@friedhoff.org):
> The patch applies cleanly , compiles and runs smoothly against 2.6.18.1.
> 
> I'm running slackware-current with a 2.6.18.1 kernel on an ext3
> filesystem.
> 
> Background why I use the patch:
> With 2.6.18 to create a tuntap interface CAP_NET_ADMIN is required.
> Qemu uses tuntap to create a tap interface as a virtual net interface.
> Instead now running qemu with root privileges to give it the right
> to create a tap interface, i granted qemu with the help of the patch and
> Kaigai Kohei's userspace tools the cap-net_admin capability. So qemu
> runs again without root privilege but has now the right to create the
> tap interface.
> 
> Thanks for the patch. It reduces my the need of suid-bit progs.
> It should be given a spin in -mm.

One question is, if this were to be tested in -mm, do we want to keep
this mutually exclusive from selinux through config, or should selinux
stack on top of this?

> I will document my experiences on http://www.friedhoff.org/fscaps.html

Cool.

thanks,
-serge
