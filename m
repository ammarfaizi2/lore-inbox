Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTETJBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 05:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTETJBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 05:01:42 -0400
Received: from holomorphy.com ([66.224.33.161]:749 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263646AbTETJBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 05:01:41 -0400
Date: Tue, 20 May 2003 02:14:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, "David S. Miller" <davem@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       Keith Mannthey <mannthey@us.ibm.com>
Subject: Re: userspace irq balancer
Message-ID: <20030520091431.GL8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"David S. Miller" <davem@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Gerrit Huizenga <gh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Andrew Morton <akpm@digeo.com>,
	Keith Mannthey <mannthey@us.ibm.com>
References: <200305191314.06216.pbadari@us.ibm.com> <1053382055.5959.346.camel@nighthawk> <20030519221111.P7061@devserv.devel.redhat.com> <1053382943.4827.358.camel@nighthawk> <1053401130.6830.3.camel@rth.ninka.net> <20030520034622.GK8978@holomorphy.com> <1053407030.13207.253.camel@nighthawk> <20030520090017.D17268@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520090017.D17268@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:03:50PM -0700, Dave Hansen wrote:
>> Does anyone have a patch to tear it out already?  Is the current proc
>> interface acceptable, or do we want a syscall interface like wli
>> suggests?

On Tue, May 20, 2003 at 09:00:18AM +0000, Arjan van de Ven wrote:
> I have no problems with the proc interface; it's ascii so reasonably
> extendible in the future for, say, when 64 cpus on
> 32 bit linux get supported. It's also not THAT inefficient since my code
> only uses it when some binding changes, not all the time.

Sorry about that; I forgot about the /proc/ part and thought the thing
was based on system calls as it stood. I wouldn't want a redundant
interface to be added.

My current cpumask_t patches handle extending the /proc/ interface to
handle an arbitrary-sized cpumask, so I should have realized this.


-- wli
