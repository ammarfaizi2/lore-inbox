Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270991AbTG1AOv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270984AbTG1AGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:06:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:179 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270991AbTG0Xq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:46:27 -0400
Date: Sun, 27 Jul 2003 16:58:31 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727165831.05904792.davem@redhat.com>
In-Reply-To: <200307280158250677.10891156@192.168.128.16>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
	<200307280140470646.1078EC67@192.168.128.16>
	<20030727164649.517b2b88.davem@redhat.com>
	<200307280158250677.10891156@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 01:58:25 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> On 27/07/2003 at 16:46 David S. Miller wrote:
> >Bas's problem can be solved by him giving a "preferred source"
> >to each of his IPV4 routes and setting the "arpfilter" sysctl
> >variable for his devices to "1".
> 
> Yes, it's another approach to solve his problem. But he must play with routing.

Precisely he must, because he has misconfigured routes for the
behavior he desires.

His problem is about source address selection when trying to
contact a given destination.

If there is no specific source address specified, the kernel may
legally use any source address, and this decision extends to ARP
handling as well.

It's totally illogical to say that it's easier for him to patch his
kernel and reboot it than fix his route configuration.
