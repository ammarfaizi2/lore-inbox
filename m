Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTETIrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 04:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTETIrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 04:47:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46033 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263633AbTETIrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 04:47:24 -0400
Date: Tue, 20 May 2003 09:00:18 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
Message-ID: <20030520090017.D17268@devserv.devel.redhat.com>
References: <200305191314.06216.pbadari@us.ibm.com> <1053382055.5959.346.camel@nighthawk> <20030519221111.P7061@devserv.devel.redhat.com> <1053382943.4827.358.camel@nighthawk> <1053401130.6830.3.camel@rth.ninka.net> <20030520034622.GK8978@holomorphy.com> <1053407030.13207.253.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053407030.13207.253.camel@nighthawk>; from haveblue@us.ibm.com on Mon, May 19, 2003 at 10:03:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:03:50PM -0700, Dave Hansen wrote:
> Does anyone have a patch to tear it out already?  Is the current proc
> interface acceptable, or do we want a syscall interface like wli
> suggests?

I have no problems with the proc interface; it's ascii so reasonably
extendible in the future for, say, when 64 cpus on
32 bit linux get supported. It's also not THAT inefficient since my code
only uses it when some binding changes, not all the time.
