Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWEEObx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWEEObx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWEEObx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:31:53 -0400
Received: from ns2.suse.de ([195.135.220.15]:28895 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750821AbWEEObw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:31:52 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	<200605021930.45068.ak@suse.de>
	<20060503161143.GA18576@sergelap.austin.ibm.com>
	<200605051302.43019.ak@suse.de>
	<20060505114338.GA12850@sergelap.austin.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 05 May 2006 16:31:49 +0200
In-Reply-To: <20060505114338.GA12850@sergelap.austin.ibm.com>
Message-ID: <p737j505yqy.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> Ok.  Then I maintain that the bitmap of changed namespaces seems
> unnecessary. 

I didn't spell it out, but it's obviously to optimize cache footprint
of clone(). I expect nsproxy to be eventually more than a cacheline
and with a bitmap test you can avoid checking it all.

-Andi
