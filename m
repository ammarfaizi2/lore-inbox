Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUDNRhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUDNRhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:37:33 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51147 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261462AbUDNRhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:37:31 -0400
Subject: Re: [PATCH 0/4] ext3 block reservation patch set
From: Mingming Cao <cmm@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <200404140911.57772.pbadari@us.ibm.com>
References: <200403190846.56955.pbadari@us.ibm.com>
	<1081903949.3548.6837.camel@localhost.localdomain>
	<20040413194734.3a08c80f.akpm@osdl.org> 
	<200404140911.57772.pbadari@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Apr 2004 10:44:02 -0700
Message-Id: <1081964645.3548.6898.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 09:11, Badari Pulavarty wrote:
> > - What locking protects rsv_alloc_hit?  i_sem is not held during
> >   VM-initiated writeout.  Maybe an atomic_t there, or just say that if we
> >   race and the number is a bit inaccurate, we don't care?
> 
> Mingming, I don't see any check to force maximum. Am I missing something ?

Nice catch! forget to check the maximum when growing the window
size...fixed it.:)

Thanks.


