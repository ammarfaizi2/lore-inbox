Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUGGFzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUGGFzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 01:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUGGFzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 01:55:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264914AbUGGFzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 01:55:16 -0400
To: Ray Lee <ray-lk@madrabbit.org>
Cc: tomstdenis@yahoo.com, eger@havoc.gtf.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
References: <1089165901.4373.175.camel@orca.madrabbit.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 07 Jul 2004 02:55:01 -0300
In-Reply-To: <1089165901.4373.175.camel@orca.madrabbit.org>
Message-ID: <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2004, Ray Lee <ray-lk@madrabbit.org> wrote:

> Which means 0xdeadbeef is a perfectly valid literal for an unsigned int.

Assuming ints are 32-bits wide.  They don't have to be.  They could be
as narrow as 16 bits, in which case the constant will have type long
or unsigned long (because long must be at least 32 bits), or they
could be wider than 32 bits, in which case the constant will be signed
int instead of unsigned int.  You might lose either way.  It's
probably safer to make it explicitly UL, except perhaps in
machine-specific files where the width of types is well-known.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
