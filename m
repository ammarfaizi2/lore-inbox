Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTIYVNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTIYVND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:13:03 -0400
Received: from calma.pair.com ([209.68.1.95]:35085 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S261471AbTIYVNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:13:00 -0400
Date: Thu, 25 Sep 2003 17:13:00 -0400
From: "Chad N. Tindel" <chad@tindel.net>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: shmulik.hen@intel.com, "Chad N. Tindel" <chad@tindel.net>,
       bonding-devel@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>
Subject: Re: [Bonding-announce] [PATCH SET][bonding] cleanup
Message-ID: <20030925211259.GA59653@calma.pair.com>
Mail-Followup-To: Jay Vosburgh <fubar@us.ibm.com>, shmulik.hen@intel.com,
	"Chad N. Tindel" <chad@tindel.net>,
	bonding-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, "Noam, Amir" <amir.noam@intel.com>,
	"Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
	"Noam, Marom" <noam.marom@intel.com>
References: <shmulik.hen@intel.com> <200309252011.53960.shmulik.hen@intel.com> <200309251733.h8PHXWpV013559@death.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309251733.h8PHXWpV013559@death.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>	I was going to add it on to the end of the clean up set, but
> >> if you want to do it, go ahead.  Nobody seems to have objected to
> >> removing the _OLD stuff, which I view as a good thing.
> 
> 	My thinking here is that any ifenslave old enough (two years
> or more) to still be using the OLD ioctl values is unlikely to work
> with the current kernel driver, and if somebody did try it, it's
> better to have the call fail outright than perform weird and
> mysterious rituals in kernel memory.  I have trouble envisioning an
> scenario where a user would be using the latest 2.4.23 kernel, but an
> ifenslave from, what, 2.2.15? 2.4.5? or so.

I was specifically told by David Miller that we are not to break binary
compatibility within a 2.4 release.  Such things had to wait until 2.5 
or later.  We can not require a user to upgrade their ifenslave within a 2.4
series kernel just to keep using the same functionality they were using in 
2.4.1.  Obviously we can require them to upgrade in order to keep using
new functionality.  So the _OLD stuff needs to stay in the 2.4 kernel.  If
this was brought up in an earlier thread, then I just missed it.

Chad
