Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUAZWAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAZWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:00:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:11489 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265216AbUAZWAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:00:36 -0500
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040126192154.2af0425b@jack.colino.net>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston> <20040122211746.3ec1018c@localhost>
	 <1074841973.974.217.camel@gaston> <20040123183030.02fd16d6@localhost>
	 <1074912854.834.61.camel@gaston> <20040124172800.43495cf3@jack.colino.net>
	 <1074988008.1262.125.camel@gaston>
	 <20040125190832.619e3225@jack.colino.net> <1075075706.848.32.camel@gaston>
	 <20040126192154.2af0425b@jack.colino.net>
Content-Type: text/plain
Message-Id: <1075154322.5659.87.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 08:58:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 05:21, Colin Leroy wrote:
> On 26 Jan 2004 at 11h01, Benjamin Herrenschmidt wrote:
> 
> Hi, 
> 
> > Hrm... It tends to do that when it's not happy with something,
> > but I did get it working... Ah yes, do
> > 
> > echo -n "disk" instead :) It doesn't like the trailing \n
> 
> Thanks, worked better. Got an oops with ohci-hcd or ehci-hcd, though. 
> shutdown worked after rmmoding these.
> However resume did not - got:

pmdisk will save to the first (or the last, I'm not sure) installed
swap partition, not what your say on the command line. It will _resume_
from what you say on the command line.

ben.


