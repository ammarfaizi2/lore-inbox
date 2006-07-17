Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWGQX7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWGQX7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 19:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWGQX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 19:59:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:977 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751241AbWGQX7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 19:59:47 -0400
Message-Id: <200607171841.k6HIfl2G003168@laptop11.inf.utfsm.cl>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Al Boldi <a1426z@gawab.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: "Why Reuser 4 still is not in" doc 
In-Reply-To: Message from Jan Engelhardt <jengelh@linux01.gwdg.de> 
   of "Mon, 17 Jul 2006 16:33:47 +0200." <Pine.LNX.4.61.0607171631460.5733@yvahk01.tjqt.qr> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 17 Jul 2006 14:41:47 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 17 Jul 2006 19:59:27 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >Using this as an argument against plug-ins is a bit strange.  I suppose 
> >somebody could go overboard and use plug-ins to implement a subKernel.  
> >Would this then imply that plug-ins are wrong?

> Ok, I've read some other threads too and so this claim should be adjusted:

> Writing a plugin (not necessarily r4 specific) that changes the semantics 
> of objects based on context (i.e. turning a file into a dir) is a bad idea 
> IMHO.

Right.

> Actually, BSD has this double-semantic to a limited degree: you can call 
> `/usr/bin/vi /usr/bin` and get some binary representation of readdir.

How is that useful? read(2) errors out on a directory, and that is fine
with me. If xemacs wants to do funky stuff when opening a directory, it is
free to notice that special case and do something (readdir(3) and its ilk
are quite useful here) about it.

[Yes, I did work on some boxen where you could read directories, but with
 the current variety of filesystems (and corresponding directory formats!)
 in Linux this way lies utter madnes.]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
