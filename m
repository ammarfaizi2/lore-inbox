Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWCJK10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWCJK10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbWCJK1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:27:25 -0500
Received: from smtp-out.google.com ([216.239.45.12]:45894 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751961AbWCJK1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:27:25 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=bIpEm5Ytek9q3CwIiOroow+0IR55qMtvR+Ev3QcQMu8nN9ksPYHIO0YaWsyg5mdjQ
	B+Pm50K5VukT5aOaylByA==
Message-ID: <44115475.7040804@google.com>
Date: Fri, 10 Mar 2006 02:27:01 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com> <20060306025800.GA27280@ca-server1.us.oracle.com> <440BC1C6.1000606@google.com> <20060306195135.GB27280@ca-server1.us.oracle.com> <p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com> <440FCA81.7090608@google.com> <20060310023305.GB28722@fieldses.org>
In-Reply-To: <20060310023305.GB28722@fieldses.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:
> On Wed, Mar 08, 2006 at 10:26:09PM -0800, Daniel Phillips wrote:
>>A poor distribution as you already noticed[1].
> 
> How did you decide that?

I looked at it and jumped to the wrong conclusion :-)

When I actually simulated it I found that the distribution is in fact
not much different from what I get from rand.  So much for trying to
pin the blame on the hash function.  Next lets try to pin the blame
on vmalloc.  (Spoiler: it's not vmalloc's fault either.)

Regards,

Daniel
