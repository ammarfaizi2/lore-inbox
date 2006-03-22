Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWCVWt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWCVWt1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWCVWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:49:27 -0500
Received: from fmr19.intel.com ([134.134.136.18]:15286 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751049AbWCVWtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:49:25 -0500
Date: Wed, 22 Mar 2006 14:48:45 -0800
From: Valerie Henson <val_henson@linux.intel.com>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjan@linux.intel.com>,
       "Theodore Ts'o" <tytso@mit.edu>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [Ext2-devel] [RFC] [PATCH] Reducing average ext2 fsck time through fs-wide dirty bit]
Message-ID: <20060322224844.GU12571@goober>
References: <20060322011034.GP12571@goober> <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143054558.6086.61.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 11:09:18AM -0800, Badari Pulavarty wrote:
> On Tue, 2006-03-21 at 17:10 -0800, Valerie Henson wrote:
> > Hi all,
> > 
> > I am working on reducing the average time spent on fscking ext2 file
> > systems.  My initial take on the problem is to avoid fscking when the
> 
> Just curious, why are you teaching ext2 same tricks that are in ext3 ?
> Is there a reason behind improving ext2 ? Are there any benefits
> of not using ext3 instead ?

ext2 is simpler and faster than ext3 in many cases.  This is sort of
cheating; ext2 is simpler and faster because it makes no effort to
maintain on-disk consistency and can skip annoying things like, oh,
reserving space in the journal.  I am looking for ways to make ext2
cheat even more.

-VAL
