Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSGCLNb>; Wed, 3 Jul 2002 07:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSGCLNa>; Wed, 3 Jul 2002 07:13:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64271 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316997AbSGCLNa>;
	Wed, 3 Jul 2002 07:13:30 -0400
Date: Wed, 3 Jul 2002 12:15:57 +0100
From: Matthew Wilcox <willy@debian.org>
To: george anzinger <george@mvista.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020703121557.L27706@parcelfarce.linux.theplanet.co.uk>
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <3D22A5F6.2CC26FC6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D22A5F6.2CC26FC6@mvista.com>; from george@mvista.com on Wed, Jul 03, 2002 at 12:21:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 12:21:26AM -0700, george anzinger wrote:
> It should also be noted that none of these is entered if a
> cli is in effect.  This is the global cli and inhibits BHs
> on all cpus.

global cli() is so heaviy deprecated, it isn't even funny.  i know
mingo has a patch to remove it entirely.  if you want to ensure that
no softirq/tasklet/timer/... is run, use spin_lock_bh().  I'll add this
information, thanks!

-- 
Revolutions do not require corporate support.
