Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVIAUVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVIAUVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbVIAUVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:21:18 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:41931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030362AbVIAUVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PCei4IwjebRESQ5UEkPJbLLMsHEBZztEZ87OEQjH1bAkrayV9o8CDINwE6X2r4tDuG7asIHTdPptQ49aD1ab4D4bqjR3WS7AoDm7hGQfFPG9+8YP7ZaMT7SqXPSpsi2OSznf4p0yM2nsscsAel23mper8ELifUkW5gb0DkwhODA=
Date: Fri, 2 Sep 2005 00:30:44 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: viro@ZenIV.linux.org.uk, Matt_Domsch@Dell.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
Message-ID: <20050901203043.GB10893@mipter.zuzino.mipt.ru>
References: <20050901064313.GB26264@ZenIV.linux.org.uk> <1125592902.27283.5.camel@i2.minyard.local> <20050901193201.GD26264@ZenIV.linux.org.uk> <43175DEC.4000600@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43175DEC.4000600@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:00:44PM -0500, Corey Minyard wrote:
> To me, It's a lot nicer to do:
> 
>    rv = user_strtoul(....);
>    if (rv < 0)
>        return rv;
> 
> Plus the scanning function I wrote handles arbitrary leading and 
> trailing space, etc.  Not a big deal, but a little nicer.

You can say from the beggining that

	echo -n "    2   " >/proc/FUBAR
	
is illegal and don't add bloat to kernel.

