Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbULOTMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbULOTMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbULOTJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:09:47 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:38534 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262454AbULOTHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:07:36 -0500
Date: Wed, 15 Dec 2004 14:07:25 -0500
To: Adam Denenberg <adam@dberg.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: bind() udp behavior 2.6.8.1
Message-ID: <20041215190725.GA24635@delft.aura.cs.cmu.edu>
Mail-Followup-To: Adam Denenberg <adam@dberg.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@linux01.gwdg.de>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org> <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com> <1103120162.5517.14.camel@sucka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103120162.5517.14.camel@sucka>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 09:16:02AM -0500, Adam Denenberg wrote:
> the Firewall from distinguishing unique dns requests.  It sees a second
> DNS request come from the linux server with the _same_ transaction ID in
> the UDP header as it is marking that session closed since it already saw
> the reply successfully.  So for example the linux server is making a dns

Stupid guess here,

The reply got dropped after it passed your firewall and before it
reached the linux server. What you are seeing is simply a retransmit
which would also have happened if the original request got lost, or if
the reply was dropped before it reached your firewall, in which case the
firewall probably would have forwarded the retransmitted request without
a problem.

I would open the window before you throw the piece of garbage out.

Jan

