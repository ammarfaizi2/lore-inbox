Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUFOW3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUFOW3P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUFOW3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:29:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:30359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265999AbUFOW3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:29:14 -0400
Date: Tue, 15 Jun 2004 15:29:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Blair Strang <bls@asterisk.co.nz>, Kyle Moffett <mrmacman_g4@mac.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Message-ID: <20040615152912.C22989@build.pdx.osdl.net>
References: <1087282990.13680.13.camel@lade.trondhjem.org> <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <1087080664.4683.8.camel@lade.trondhjem.org> <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com> <1087084736.4683.17.camel@lade.trondhjem.org> <DD67AB5E-BCCF-11D8-888F-000393ACC76E@mac.com> <87smcxqqa2.fsf@asterisk.co.nz> <1087282990.13680.13.camel@lade.trondhjem.org> <8666.1087292194@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8666.1087292194@redhat.com>; from dhowells@redhat.com on Tue, Jun 15, 2004 at 10:36:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> You might want to look at this patch. It's what I've come up with to support
> kafs, but it's general, and should work for anything. It's been built along
> Linus's guidelines, and has Linus's approval, contingent on something actually
> using it fully.
> 
> You can use the session keyring number as a PAG ID if you wish.
> 
> I've a sample aklog program (key submission) should you be interested.

I'd be intereseted.  BTW, I just took a brief look and had a quick
question.

> +	if (bprm->e_uid != current->uid)
> +		suid_keys(current);
> +	exec_keys(current);
> +

would the security module be expected update/revoke keys if the thing changes
security domains on exec?

>  	task_lock(current);
>  	unsafe = unsafe_exec(current);
>  	security_bprm_apply_creds(bprm, unsafe);

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
