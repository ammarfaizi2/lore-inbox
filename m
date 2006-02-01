Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422868AbWBASjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422868AbWBASjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWBASjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:39:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422866AbWBASji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:39:38 -0500
Date: Wed, 1 Feb 2006 10:39:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: md@Linux.IT (Marco d'Itri), netdev@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Backward compatibility and WAN netdev configuration
Message-ID: <20060201103931.08ad581d@dxpl.pdx.osdl.net>
In-Reply-To: <m3r76n3p4k.fsf@defiant.localdomain>
References: <m3psm7tksr.fsf@defiant.localdomain>
	<20060201144917.GA7644@wonderland.linux.it>
	<m3r76n3p4k.fsf@defiant.localdomain>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Feb 2006 19:33:47 +0100
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> md@Linux.IT (Marco d'Itri) writes:
> 
> > Why you cannot support autoloading the modules when a specific protocol
> > is needed?
> 
> I probably could but it would complicate things a bit - currently only
> the protocol module knows about existence of its protocol.
> 
> I will look at it, though. Thanks.

The modern way is to not have any entries in modprobe.conf, and do all
the module loading via kernel module_aliases. Modprobe.conf is then
reserved for handling workarounds for special cases
-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
