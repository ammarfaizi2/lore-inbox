Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUIFS5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUIFS5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUIFS5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:57:41 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:4140 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268468AbUIFS5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:57:39 -0400
Date: Mon, 6 Sep 2004 21:00:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Simplify vmlinux generation
Message-ID: <20040906190052.GB8230@mars.ravnborg.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040905201235.GC16901@mars.ravnborg.org> <200409061841.i86Ifdnj008952@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409061841.i86Ifdnj008952@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 02:41:39PM -0400, Horst von Brand wrote:
> Sam Ravnborg <sam@ravnborg.org> said:
> 
> [...]
> 
> Some comments interspersed.
> 
> Signed off by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
> 
> (Not too much intellect in here, and no property, but...)

If you could just tell me why akpm's x86_64 do not boot with this one :-(
I will fix my wording as you suggest - thanks.

 > +#
> > +# vmlinux version cannot be updated during normal descending-into-subdirs
> 
>      The vmlinux version? Or some file?
uname -v (the number after #)

> >  
> > -define rule_verify_kallsyms
> > +define verify_kallsyms
> 
> Why delete "rule_" here? Down you create a new rule with "rule_"

rule_ is used only for the defines used in $(call if_changed_rule ...
verify_kallsyms are called direct.

rule_ksym_ld is called using $(if_changed_rule ...)

	Sam
