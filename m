Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWAKNnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWAKNnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWAKNnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:43:16 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:13206 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751197AbWAKNnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:43:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tNt7aNEeJeyxLE4waD+dKNBpmARKpCM8GgjwlsuHCvz5DXFLK45KEHWXiSVi4Y4XovDY9ZFs+k9B3KKs/OboTehZta+Ns73V1mvegAVd9gRgjnn8KVwSndxTYBnH/5dauMNbYmDgOZw+/GgeFZ1DQ8gDYrhJTC78enH/t0NUQsE=
Message-ID: <43C50B6D.6090608@gmail.com>
Date: Wed, 11 Jan 2006 21:43:09 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
References: <20060105045212.GA15789@redhat.com> <200601111331.45940.ak@suse.de> <43C502AA.1040200@gmail.com> <200601111417.19234.ak@suse.de>
In-Reply-To: <200601111417.19234.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 11 January 2006 14:05, Antonino A. Daplas wrote:
>> Andi Kleen wrote:
>>> On Wednesday 11 January 2006 13:24, Antonino A. Daplas wrote:
>>>
>>>> In the VGA console, all buffers, including scrollback is in video RAM, but
>>>> the size is fixed and is very small.
>>> I wonder if that can be fixed.
>> It can be done, but it will affect VGA console performance.
> 
> By how much? As long as it still scrolls reasonably fast it would be ok for me.

Each character will need to be written twice, one to VGA RAM and another to
the shadow/scrollback buffer in system RAM. It would still be reasonably fast.

Perhaps I can implement this for vgacon.

Tony
