Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWFUG6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWFUG6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWFUG6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:58:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31284 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751122AbWFUG6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:58:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A1b3dr9xFJR3Cc0lNRzw2n9b0G+zDJl/GFel/DgjjCBh9+eGazhILzuDRf7mY9qL/G3owxcNLfngEUOjaZ6ICX0pJC3tE289vLlSJ+TXz5dyC4r0+haR7KV+b/O6vpegJYBRURKRLnINKQctTWvNmbfxwQsyEEtRXWN/J7hYwV8=
Message-ID: <81b0412b0606202358l4148be0as54cf2c0e3da93f7f@mail.gmail.com>
Date: Wed, 21 Jun 2006 08:58:32 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Arijit Das" <Arijit.Das@synopsys.com>
Subject: Re: Getting CPU Usage of a running child process
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE9596587@IN01WEMBX1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <AcY92pPSyN42OXgfQIad3rhpQJCOmw==>
	 <7EC22963812B4F40AE780CF2F140AFE9596587@IN01WEMBX1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Arijit Das <Arijit.Das@synopsys.com> wrote:
> The times() function gets me the system/user CPU usage of me (invoking
> process) and all my terminated/waited children.
>
> Is there any User Space API/way for me (a process) to get the
> system/user CPU usage of one of my currently running child process? Am
> looking for a portable solution...not sure if there is any

There is a way to get the times for all children:
getrusage(RUSAGE_CHILDREN, &usage);
You can double-fork to get the info for a specific subprocess.
/proc is, as you probably noticed, not portable.
