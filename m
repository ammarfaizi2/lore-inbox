Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263916AbUDPXNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbUDPXNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:13:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263916AbUDPXNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:13:19 -0400
Message-ID: <40806880.1030007@pobox.com>
Date: Fri, 16 Apr 2004 19:13:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       bfennema@falcon.csc.calpoly.edu
Subject: Re: Fix UDF-FS potentially dereferencing null
References: <20040416214104.GT20937@redhat.com> <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040416220014.GI24997@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Apr 16, 2004 at 10:41:04PM +0100, Dave Jones wrote:
> 
>>Move size instantiation after null check for 'dir', nearer
>>to where its first used.
> 
>  
> Check in question is a BS - it never gets NULL passed as dir.


Yes, it looks like a lot of these NULL checks caught can be fixed simply 
by removing bogus and/or redundant checks.

	Jeff



