Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWCQVGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWCQVGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 16:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWCQVGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 16:06:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59529 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932766AbWCQVGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 16:06:22 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 17 Mar 2006 22:01:58 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] ieee1394/ohci1394 : CycleTooLong interrupt management
To: Jean-Baptiste Mur <jeanbaptiste@maunakeatech.com>
cc: linux1394-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603171437.57519.jeanbaptiste@maunakeatech.com>
Message-ID: <tkrat.6f7cb1ffe1d70bc4@s5r6.in-berlin.de>
References: <200603171437.57519.jeanbaptiste@maunakeatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.786) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Baptiste MUR wrote:
...
> Kernel version : 2.6.16-rc4

(actually plus an ohci1394 patch from the linux1394 development tree)

...
> +                /* If this event occurs, we try to reactivate the "cycle 
> master" bit. */
> +                reg_write(ohci, OHCI1394_LinkControlSet, 
> OHCI1394_LinkControl_CycleMaster);
...

Three minor nits:

There are tabs replaced by spaces and superfluous line breaks inserted
in your posting. Take care that the mailer does not mangle whitespace.
If you cannot prevent this nor switch the mailer, send the patch as
attachment without recoding (i.e. 7bit encoding, not base64 or the
like).

Take care of a maximum line length of 80 characters. For example:

		/* Try to reactivate the "cycle master" bit. */
		reg_write(ohci, OHCI1394_LinkControlSet,
			  OHCI1394_LinkControl_CycleMaster);

The comment is unnecessary since the actual code is clear enough, at
least IMO.

Anyway, thanks again for identifying this problem.
-- 
Stefan Richter
-=====-=-==- --== =---=
http://arcgraph.de/sr/

