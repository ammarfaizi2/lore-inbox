Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUBRPmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267574AbUBRPmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:42:55 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:18097 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267563AbUBRPmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:42:53 -0500
Date: Wed, 18 Feb 2004 15:40:12 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Message-ID: <20040218154012.GP6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040217235431.GF6242@redhat.com> <wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org> <20040218111612.GM6242@redhat.com> <wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp1xos5s2o.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 04:24:15PM +0100, Marc Zyngier wrote:

 > It looks like hp100 is at least broken wrt probing, since it lacks a
 > EISA-ID table terminator. What about changing it to :
 > 
 > static struct eisa_device_id hp100_eisa_tbl[] = {
 >         { "HWPF180" }, /* HP J2577 rev A */
 >         { "HWP1920" }, /* HP 27248B */
 >         { "HWP1940" }, /* HP J2577 */
 >         { "HWP1990" }, /* HP J2577 */
 >         { "CPX0301" }, /* ReadyLink ENET100-VG4 */
 >         { "CPX0401" }, /* FreedomLine 100/VG */
 >         { "" },        /* THIS ENTRY IS MANDATORY !!! */
 > };

I'll give it a try in a few minutes..

 > Dave> I've seen same exactly the same behaviour with quite a few other
 > Dave> modules.  For my 'modprobe/rmmod script-o-death', I just ended
 > Dave> up disabling EISA in that test tree, as it was too painful to
 > Dave> hit this issue over and over, but its a real situation that
 > Dave> could bite users of for eg, vendor kernels.
 > 
 > What are the other modules ?

See the 'modprobe script-o-doom' I posted last night. Just loading and
unloading various modules causes crashes.

 > I'd like to reproduce the problem (I have
 > no PCI hp100 to check if the above fixes the problem).

Me either. This is the case that crashes. I'll bet it works fine
if you actually have hardware, as that was the case that got tested
when the driver got changed last.

		Dave

