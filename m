Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVFWCEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVFWCEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFWCEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:04:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262005AbVFWCDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:03:37 -0400
Date: Wed, 22 Jun 2005 22:03:24 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: lorenzo@gnu.org
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: Re: [patch 1/1] selinux: minor cleanup in the hooks.c:file_map_prot_check()
 code
In-Reply-To: <Xine.LNX.4.44.0506222150590.10175-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0506222203060.10598-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, James Morris wrote:

> > @@ -2485,7 +2487,7 @@ static int selinux_file_mprotect(struct 
> >  		 * check ability to execute the possibly modified content.
> >  		 * This typically should only occur for text relocations.
> >  		 */
> > -		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
> > +		rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
> >  		if (rc)
> >  			return rc;
> >  	}
> > _
> 
> No, causes ppc32 warning.

Actually, this one's ok.


- James
-- 
James Morris
<jmorris@redhat.com>


