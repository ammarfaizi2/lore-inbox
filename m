Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVCPWDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVCPWDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 17:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVCPWAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 17:00:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:60665 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262822AbVCPV55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:57:57 -0500
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: len.brown@intel.com
Subject: Re: [PATCH 1/2] Thinkpad Suspend Powersave: Fix ACPI's GFP_KERNEL allocations in contexts that can sleep
Date: Wed, 16 Mar 2005 22:57:34 +0100
User-Agent: KMail/1.7.1
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-thinkpad@linux-thinkpad.org, benh@kernel.crashing.org,
       Andrew Morton <akpm@osdl.org>, volker.braun@physik.hu-berlin.de
References: <1.518178082@mit.edu> <2.518178082@mit.edu> <20050316132952.3af7cff8.akpm@osdl.org>
In-Reply-To: <20050316132952.3af7cff8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503162257.34778.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> > This fixes a problem originally reported by Christian Borntraeger where
> >  during the wakeup from a suspend-to-ram, several "sleeping function
> >  called from invalid context" warning messages are issued.  Unlike a
> >  previous patch which attempted to solve this problem, we avoid doing
> > an GFP_ATOMIC kmalloc() except when explicitly necessary.

Len,
you indicated that you are going to address the S3 sleeping function issue 
after the development for 2.6.12 has started with an invasive but correct 
fix. 
(http://marc.theaimsgroup.com/?l=acpi4linux&m=110978961501752&w=2)
Can you give an overview about your progress?

cheers

Christian
