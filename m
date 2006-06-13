Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWFMFsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWFMFsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWFMFsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:48:09 -0400
Received: from ns1.suse.de ([195.135.220.2]:12678 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932521AbWFMFsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:48:07 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.16-rc6-mm2
Date: Tue, 13 Jun 2006 07:48:02 +0200
User-Agent: KMail/1.9.3
Cc: Keith Owens <kaos@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <10021.1150175320@kao2.melbourne.sgi.com> <200606130718.35498.ak@suse.de> <448E5070.90003@yahoo.com.au>
In-Reply-To: <448E5070.90003@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130748.02832.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You can't do this in general, because CPU hotplug will reset the
> affinity mask if the CPU is unplugged. I'd just say: don't do that.

Good point.
> 
> However you can get some similar functionality by putting stuff in
> task_struct.

Or better don't do it at all. per cpu data and sleeping just doesn't mix.

-Andi
