Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbTFNT0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 15:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbTFNT0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 15:26:49 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24077 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265699AbTFNT0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 15:26:48 -0400
Date: Sat, 14 Jun 2003 21:40:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Bugs sitting in the NEW state for more than 28 days
Message-ID: <20030614194026.GA3733@mars.ravnborg.org>
Mail-Followup-To: Stacy Woods <stacyw@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <3EEA15EC.7080203@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEA15EC.7080203@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 02:20:28PM -0400, Stacy Woods wrote:
> There are 125 bugs sitting in the NEW state for more than 28 days
> 
> 228  Other      Other      bugme-janitors@lists.osdl.org
> Make pdfdocs/psdocs/htmldoc fail in 2.5.54

Fixed in linus-latest.
Note that the changes to kernel-doc make it spit out warnings for
all parameters in a funtion which is not documented.
A better solution might be to spit out warnings for parameters
documented but not present.
My perl skills did not suffer for this.

The real errors were in one .tmpl files and one .c file,
The other changes in kernel-doc just helped me identifying the root
cause.

> 384  Other      Modules    bugme-janitors@lists.osdl.org
> 2.5.62 make modules *.ko has no CRC

I cannot provoke this one. Anyone with more details?
Otherwise I would like to have it closed.

> 485  Other      Other      bugme-janitors@lists.osdl.org
> "make rpm" fails; no kernel-2.5.65/debugfiles.list

Alan Cox checked in a correction that was present in 2.5.66.
I have tried "make rpm" with 2.5.70 with success.
Can be closed.

	Sam
