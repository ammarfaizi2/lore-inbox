Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVCOSsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVCOSsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCOSsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:48:35 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:8722 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261735AbVCOSpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:45:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PqxnECIukogRWCSrRRWIz8udTq/Zv5bL5hcLyeSz8SJyzWwnAsfjHAo1M39uJhCOL27GmQO5LMXsIJBRqkYeFlRQRf/ICklLLpiBOq1Ij1JSWOcf1eG8qeEpVA6gWbUxRX/qqR5Yu0UDyQK66vMbGzGnVRBCM9DBLLWMa6uSwTI=
Message-ID: <2cd57c9005031510443ba02e8@mail.gmail.com>
Date: Wed, 16 Mar 2005 02:44:03 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] oom_kill fix
Cc: coywolf@sosdg.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050314180258.271acfab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050314181442.GA31020@everest.sosdg.org>
	 <20050314180258.271acfab.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 18:02:58 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
> >
> >  This oom_kill fix is to do mmput(mm) a bit earlier and returning 0 or 1
> >  to indicate success or failure instead of returning mm_struct pointer.
> 
> Why is this a "fix"?  What bug is it fixing?
> 

It's at least a coding style improvement and lets the code be less obfuscated.
It increases the system survival possibilities by doing mmput immediately
and reduces the chances of oom killing another process unnecessarily, IMHO.

Or rather rename "fix" to "cleanup".

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
