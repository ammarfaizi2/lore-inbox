Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVCVIGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVCVIGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVCVIGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:06:36 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:22518 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262543AbVCVIG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:06:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lGBmNZtEtYGZxE0ezohNGnFzQovSbj/i/FI8Ww9ZZsVob2pzHYWKUWvtrfvbvcsezjzYCKHESMNNC9NAqnuO3zvTpAct/QUB/KLAJjl+ENu/45VdXTD4ETo6der7gOOU5ENnkuJxpIBMMM1PbysFe4no3re1yz38zWlbnTw2yg8=
Message-ID: <aec7e5c3050322000677d5f22f@mail.gmail.com>
Date: Tue, 22 Mar 2005 09:06:29 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Johannes Stezenbach <js@linuxtv.org>, Magnus Damm <damm@opensource.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dvb_frontend: MODULE_PARM_DESC
In-Reply-To: <20050322025104.GA18067@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050321154226.19053.36781.35540@clementine.local>
	 <20050322025104.GA18067@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 03:51:04 +0100, Johannes Stezenbach <js@linuxtv.org> wrote:
> On Mon, Mar 21, 2005 at 05:10:27PM +0100, Magnus Damm wrote:
> > Remove "dvb_"-prefix from parameters. Without the patch all parameters except
> > the declaration of parameter "frontend_debug" have a "dvb_"-prefix.
> 
> Why is that dvb_ prefix a problem?

It is no biggie and probably not worth breaking users' configuration
like you said, but most drivers do not have their KBUILD_MODNAME
included in the parameter names.

Setting parameters that have KBUILD_MODNAME as prefix from the kernel
commandline is then done by KBUILD_MODNAME.KBUILD_MODNAME_xxx and that
is plain ugly - especially when a list of parameters are generated
from the source.
Some bad citizens IMO:

dvb.dvb_shutdown_timeout, asus.asus_gid, arlan.arlan_entry_debug

> > Error detected with section2text.rb, see autoparam patch.
> 
> Please only fix errors and do not rename other parameters. We shouldn't
> break users' modprobe.conf option settings.

Ok, just fixing errors: frontend_debug should be renamed to
dvb_frontend_debug or the parameter description should at least match
the parameter...
 
Thanks,

/ magnus
