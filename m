Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVAFTN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVAFTN3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbVAFTLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:11:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262967AbVAFTJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:09:12 -0500
Date: Thu, 6 Jan 2005 14:07:04 -0500
From: Dave Jones <davej@redhat.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, "L. A. Walsh" <law@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zap the ACPI shutdown bug (was Re: Reviving the concept of a stable series)
Message-ID: <20050106190704.GA16373@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Barry K. Nathan" <barryn@pobox.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>, "L. A. Walsh" <law@tlinx.org>,
	linux-kernel@vger.kernel.org
References: <41D91707.6040102@tlinx.org> <41D9C53A.3030503@tmr.com> <20050104130846.GD2708@holomorphy.com> <20050104182017.GE19167@redhat.com> <20050106182336.GB2390@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106182336.GB2390@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 10:23:36AM -0800, Barry K. Nathan wrote:
 > If the "backport" jokes don't make sense yet, consider this dilemma: If
 > a backported patch has not been committed upstream yet, then is it
 > really a backport?

In this case, the patch was taken from 2.6.9-mm.
Whilst it's not officially 'upstream', and things do occasionally
get merged there that don't move to Linus' tree, this one was
chosen on the merits that it was a useful feature worthy of inclusion.

Quite a few features have been beaten out this way.
Ext3 reservations, 4K stacks to name two off the top of my head.
All these have had exposure in Fedora testing trees which has turned
up bugs no-one saw when they were in -mm. Had they not gotten
that exposure, those features may have never got to where they
are today.

The odd part is.. this patch was included in our 2.6.8 tree
without problems. It also didn't cause problems for everyone
when it was in -mm (though some did see the same bug).

Spooky.

 > The following patch removes the ACPI shutdown bug from 2.6.9-1.724_FC3,
 > at least in my testing on my affected system. The diff almost succeeds
 > in speaking for itself, but to fully understand what it's saying, you
 > will also need to grep a 2.6.10 Fedora kernel-2.6.spec file for "kexec".
 > 
 > -Barry K. Nathan <barryn@pobox.com>
 > 
 > --- kernel-2.6.spec.ACPI-shutdown-bug	2005-01-06 08:40:15.264970728 -0800
 > +++ kernel-2.6.spec.no-ACPI-shutdown-bug	2005-01-06 08:40:08.629979400 -0800
 > @@ -863,7 +863,7 @@
 >  %patch1081 -p1
 >  
 >  # Kexec in preparation for kexec-based dump
 > -%patch1090 -p1
 > +#patch1090 -p1

Thanks.  Had I not already dropped this when I updated our tree to 2.6.10,
this would have been useful.

		Dave

