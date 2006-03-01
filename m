Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWCAQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWCAQeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCAQeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:34:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56479 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751491AbWCAQeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:34:04 -0500
Message-Id: <200603011633.k21GXwXD019342@laptop11.inf.utfsm.cl>
To: Hauke Laging <mailinglisten@hauke-laging.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: VFS: Dynamic umask for the access rights of linked objects 
In-Reply-To: Message from Hauke Laging <mailinglisten@hauke-laging.de> 
   of "Wed, 01 Mar 2006 04:54:15 BST." <200603010454.15223.mailinglisten@hauke-laging.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Wed, 01 Mar 2006 13:33:58 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 01 Mar 2006 13:33:59 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hauke Laging <mailinglisten@hauke-laging.de> wrote:
> Am Mittwoch 01 März 2006 03:45 schrieb Sam Vilain:
> > Of course this doesn't work if, like /tmp and /var/tmp are shipped as on
> > every distribution, the directory has permissions 1777.

> I had this idea after the announcement of such a security problem in an 
> antivirus software. The rpm package was buggy and set wrong rights for the 
> installation directory /usr/whatever. So this is a real-world problem.

Right, some programs are broken.

[...]

> > What problem you are trying to solve?

> I want to prevent the case that superuser processes accidentally read or 
> write (system) files because they have been redirected there by a symlink 
> which has been created by a user who cannot access (or at least write) 
> these files hinself.

Don't do that then. Programs running as superuser should always be extra
careful. Nothing (or nearly) should ever be run as "normal user" root.

Yes, root can shoot its feet at will. Always has been able to. Doing it by
blindly following a symlink planted in her home or in /tmp by the local
cracker-wannabe is just one (very minor) more way of doing so.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
