Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVGLOSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVGLOSV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGLOSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:18:12 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:21884 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261477AbVGLOQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:16:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RJg6cStpilJUCV0iaYnoHJL6ztJXW+L8PIa63Smk6/kGqqI6s7fPx9gLMt/GrFlWgBt810R50oTRSzrl9VsBPOkclbI4sCu5kzKoVcQVu6SAqm4I0TpbLrRbSe8DnJ2PBQe+qHDpNvcrNMPxq+f6vH6wvCTm0poKkHTIiAGyLYs=
Message-ID: <42D3D20E.4010306@gmail.com>
Date: Tue, 12 Jul 2005 16:22:06 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: "scheduling while atomic" ?
References: <42D3C37C.6040401@gmail.com>	 <1121175049.6917.19.camel@localhost.localdomain> <42D3CEEC.90603@gmail.com> <1121177471.6917.24.camel@localhost.localdomain>
In-Reply-To: <1121177471.6917.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>I assume that you call register_netdev in your module. Since this was
>running insmod, this is probably called from the module_init. So what
>reason do you have a lock from beginning to end?  Looking at this, you
>can't call register_netdev while holding a spin_lock since it looks like
>it will schedule.  So the fix is to release whatever spin lock that you
>have before calling register_netdev.
>  
>
Thank you for your help. This actually works ;-)

--mb
