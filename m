Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270765AbTHFRuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270767AbTHFRuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:50:10 -0400
Received: from 217-124-16-71.dialup.nuria.telefonica-data.net ([217.124.16.71]:20870
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S270765AbTHFRuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:50:08 -0400
Date: Wed, 6 Aug 2003 19:50:06 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6-test2, ipsec in tunneling mode
Message-ID: <20030806175006.GA12880@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030806124323.1ad8f79a.jpenny@universal-fasteners.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806124323.1ad8f79a.jpenny@universal-fasteners.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 06 August 2003, at 12:43:23 -0400,
Jim Penny wrote:

> Does anyone have a tested example of tunneling mode working on
> linux-2.6-test2?  If so would you please email it to me.  At this point
> I don't care about authentication method, don't care about addresses,
> etc.  I just want to see a real example.
> 
I don't know if you are the same person who asked something very similar
in another mailing list I am also subscribed to, but I followed the
suggestion og Bret Hubert to recompile ipsec-tools against recent kernel
headers, and (nearly) all my problems went away at once.

I used "apt-get source ipsec-tools" from Debian Sid, and just edited
"debian/rules" to delete the ./configure option that points to the
includes packaged with ipsec-tools (so configure looks them at the usual
default location of /lib/modules/$KERNEL_VERSION/build/includes, where,
in my setup, 2.6.0-test2-mm2 sources are).

There is additional documentation about the native IPsec implementation
available in 2.5.x kernels at http://lartc.org, in the HOWTO.

Hope it helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-mm2)
