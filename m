Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbVCKX3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVCKX3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCKX1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:27:18 -0500
Received: from smtp05.auna.com ([62.81.186.15]:37519 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S261814AbVCKXYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:24:54 -0500
Date: Fri, 11 Mar 2005 23:24:50 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: AGP bogosities
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<1110579068l.8904l.0l@werewolf.able.es> <20050311221838.GG4185@redhat.com>
	<1110581163l.5796l.0l@werewolf.able.es>
	<1110582991.8513.13.camel@nosferatu.lan>
	<1110583058l.5650l.0l@werewolf.able.es>
	<1110583429.8513.18.camel@nosferatu.lan>
In-Reply-To: <1110583429.8513.18.camel@nosferatu.lan> (from
	azarah@nosferatu.za.org on Sat Mar 12 00:23:48 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1110583490l.6009l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.12, Martin Schlemmer wrote:
> On Fri, 2005-03-11 at 23:17 +0000, J.A. Magallon wrote:
> > On 03.12, Martin Schlemmer wrote:
> > > On Fri, 2005-03-11 at 22:46 +0000, J.A. Magallon wrote:
> > > > On 03.11, Dave Jones wrote:
> > > > > On Fri, Mar 11, 2005 at 10:11:08PM +0000, J.A. Magallon wrote:
> > > > >  > 
...
> > > 
> > 
> > Just curiosity, what says your /proc/driver/nvidia/agp/status ?
> > 
> 
> -----
> # cat /proc/driver/nvidia/agp/status
> Status:          Enabled
> Driver:          AGPGART
> AGP Rate:        8x
> Fast Writes:     Enabled
> SBA:             Enabled
> -----
> 

Ah, I got it. The AGPRate is a _limit_ and is not active by default. It is
not the rates to probe...
If you activate it and dont change to 15 you limit the driver to x4.
If you do nothing, no limit.

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam3 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #3


