Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbULVXtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbULVXtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbULVXtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:49:47 -0500
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:48027 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262079AbULVXtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:49:45 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,83,1102287600"; 
   d="scan'208"; a="1193568:sNHT21684176"
Message-ID: <41CA0813.1070707@fujitsu-siemens.com>
Date: Thu, 23 Dec 2004 00:49:39 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, i386: fpu handling on sigreturn
References: <41C9B21F.90802@fujitsu-siemens.com.suse.lists.linux.kernel> <p73mzw5zzk2.fsf@verdi.suse.de>
In-Reply-To: <p73mzw5zzk2.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com> writes:
> 
>>Now, the interrupted processes fpu no longer is cleared!
> 
> 
> I agree it's a bug, although it's probably pretty obscure so people
> didn't notice it.  The right fix would be to just clear_fpu again
> in this case.  The problem has been in Linux forever.
Wouldn't it be better to also reset used_math to 0? (As it has been,
before the sighandler was started)

Bodo
> 
> Here's an untested patch for i386 and x86-64. 
> 
> -Andi
