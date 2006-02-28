Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWB1Lt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWB1Lt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbWB1Lt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:49:26 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:38346 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1750895AbWB1LtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:49:25 -0500
Date: Tue, 28 Feb 2006 12:49:16 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, garloff@suse.de
Subject: Re: Linux v2.6.16-rc5 - regression
Message-ID: <20060228114916.GA26352@brainysmurf.cs.umu.se>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060228093846.GA24867@brainysmurf.cs.umu.se> <20060228020336.79616850.akpm@osdl.org> <20060228114132.GA25749@brainysmurf.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060228114132.GA25749@brainysmurf.cs.umu.se>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 28, 2006 at 02:03:36AM -0800, Andrew Morton wrote:
> > 
> > Well yes, it'll be something else - perhaps some TSC change or something.

Looking closer I see that CONFIG_X86_PM_TIMER defaults to y in
2.6.16-rc5, whereas I have had it unset in earlier kernels.
This changed silently when I ran 'make oldconfig', and is most likely
the source of this "problem".

	Peter Hagervall

-- 
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Umeå, SE-901 87 Umeå.....fax: +46(0)90 786 6126
