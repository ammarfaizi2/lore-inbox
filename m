Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUELUsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUELUsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbUELUsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:48:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65417 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263734AbUELUqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:46:16 -0400
Message-ID: <40A28D09.2080006@pobox.com>
Date: Wed, 12 May 2004 16:46:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Olderdissen <jan@ixiacom.com>
CC: "'Andrew Morton'" <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       davidel@xmailserver.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
References: <15FDCE057B48784C80836803AE3598D50627ACD5@racerx.ixiacom.com>
In-Reply-To: <15FDCE057B48784C80836803AE3598D50627ACD5@racerx.ixiacom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Olderdissen wrote:
> Couple nitpicks:
> 
> 
>>#if HZ=1000
> 
> 
> #if HZ==1000
> 
> 
>>#define	MSEC_TO_JIFFIES(msec) (msec)
>>#define JIFFIES_TO_MESC(jiffies) (jiffies)
>>#elif HZ=100
> 
> 
> #elif HZ==100
> 
> 
>>#define	MSEC_TO_JIFFIES(msec) (msec * 10)
>>#define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
> 
> 
> #define JIFFIES_TO_MSEC(jiffies) (jiffies / 10)
> 
> 
>>#else
>>#define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
>>#define	JIFFIES_TO_MSEC(jiffies) ...
>>#endif


And let's use something other than the name of a global variable in the 
macros...  it hurts my brain, at least...  :)

	Jeff



