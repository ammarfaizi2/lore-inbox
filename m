Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVEDTMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVEDTMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVEDTMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:12:48 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:7454 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261394AbVEDTMb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:12:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DeNSZOUeVIuaBTRf0NAZs9/94sDnAk1XIQjl9Z5Dehev0z0/TZImTgIZDtqLxMEIHJiEF0VpewJRna4va/27pNe3yxcgZwyPDzwZkjt3MdusZh1P9MRa8us4xOU2W+JLWmX4haQXx7wHyM0gVIPqv8F7jjEGp2FXqyFlq2967xg=
Message-ID: <b6d0f5fb05050412126dc4cd28@mail.gmail.com>
Date: Wed, 4 May 2005 20:12:29 +0100
From: Cameron Harris <thecwin@gmail.com>
Reply-To: Cameron Harris <thecwin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
In-Reply-To: <200505011707.35461.damir.perisa@solnet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050430164303.6538f47c.akpm@osdl.org>
	 <200505011707.35461.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/05, Damir Perisa <damir.perisa@solnet.ch> wrote:
> i updated from rc2-mm3 to rc3-mm2 and now i observe something strange:
> the cpu is running all the time at 100% because of the kswapd0 that is
> running always and not becomming idle.
> 
> after having the computer running for about one hour, top says this about
> kswapd0:
> 
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>   155 root      25   0     0    0    0 R 89.6  0.0  38:56.06 kswapd0
> 
> the config file you can find here:
> http://cvs.archlinux.org/cgi-bin/viewcvs.cgi/kernels/kernel26mm/config?rev=1.18&cvsroot=Extra
> 
> regards,
> 
> Damir Perisa
> 
> --
> A thing worth doing is worth the trouble of asking somebody else to do it.
> 
> 
> 

I can sort of confirm this, except on a different kernel version.
This kswapd0 taking 100% cpu is on my 2.6.12-rc2-mm3 compiled with cachefs. 
Next time I boot into it I can check my sysrq-P and see if cachefs is
causing it on mine...
It tends to be after something has heavily used my hard drive. 
-- 
Cameron Harris
