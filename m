Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTEGSuC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTEGSuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:50:02 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11489 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264197AbTEGSuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:50:01 -0400
Message-ID: <3EB957FA.4080900@us.ibm.com>
Date: Wed, 07 May 2003 12:01:14 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <linux@lundell-bros.com>
CC: root@chaos.analogic.com,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305071008080.11871@chaos> <p05210601badeeb31916c@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> One thing that would help (aside from separate interrupt stacks) 
> would be a guard page below the stack. That wouldn't require any 
> physical memory to be reserved, and would provide positive indication 
> of stack overflow without significant runtime overhead.

x86 doesn't really have big physical shortages right now.  But, the
_virtual_ shortages are significant.  The guard page just increases the
virtual cost by 50%.

The stack overflow checking in -mjb uses gcc's mcount mechanism to
detect overflows.  It should get called on every single function call.

-- 
Dave Hansen
haveblue@us.ibm.com

