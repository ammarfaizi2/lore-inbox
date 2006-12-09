Return-Path: <linux-kernel-owner+w=401wt.eu-S1758849AbWLIWeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758849AbWLIWeU (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbWLIWeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:34:20 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2068 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758849AbWLIWeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:34:20 -0500
Date: Sat, 9 Dec 2006 23:34:19 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix sysfs_create_bin_file warnings)
Message-ID: <20061209223418.GA76069@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jean Delvare <khali@linux-fr.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org> <1165694351.1103.133.camel@localhost.localdomain> <20061209123817.f0117ad6.akpm@osdl.org> <20061209214453.GA69320@dspnet.fr.eu.org> <20061209135829.86038f32.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209135829.86038f32.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 01:58:29PM -0800, Andrew Morton wrote:
> On Sat, 9 Dec 2006 22:44:53 +0100
> Olivier Galibert <galibert@pobox.com> wrote:
> > Hmmm, I don't understand.  Which is the bug, having a sysfs file
> > creation fail or going on if it happens?
> 
> Probably the former, probably the latter.
> 
> There may be situations in which we want do to "create this sysfs file if
> it doesn't already exist", but I'm not aware of any such.
> 
> Generally speaking, if sysfs file creation went wrong, it's due to a bug. 
> The result is that the driver isn't working as intended: tunables or
> instrumentation which it is designed to make available are not present.  We
> want to know about that bug asap so we can get it fixed.

Hmmm, then why don't you just drop the return value from the creation
function and BUG() in there is something went wrong.  That would allow
for better error messages too.

  OG.

