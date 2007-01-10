Return-Path: <linux-kernel-owner+w=401wt.eu-S932567AbXAJAAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbXAJAAy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbXAJAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:00:54 -0500
Received: from web55611.mail.re4.yahoo.com ([206.190.58.235]:33499 "HELO
	web55611.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932557AbXAJAAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:00:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Cen5jvCbd+Ge1ZghITAjSdt6HejZ4L3CQ7l48Kt2nd9KNuudd6kIl//Vh4fz3A7bgdB0vSh7EmwaTXRu7KgDUcoKOf/7qIh14CyfngMnmxnUquhYJJyYzyHqgC0q4+9ilOGaCefd9bFd2IzvCjlGjWgpgaDinFZN2bXHGxkViCE=;
X-YMail-OSG: zxxxUVMVM1lcoiSeLNcnh6Tu5pvRJXRQHemosV0aCKhVLJAy5NSIp7NjBK3feVhwJH57HGBQp3xh4NMDnxCHnrhVyykH7KgCapp615rgCyslSG_iKvbjQ48vA6M9fY99G.t8WafpXF1IHd8-
Date: Tue, 9 Jan 2007 16:00:51 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Valdis.Kletnieks@vt.edu
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200701092257.l09MvM82029636@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <802696.41460.qm@web55611.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Valdis.Kletnieks@vt.edu wrote:

> On Tue, 09 Jan 2007 11:02:35 PST, Amit Choudhary said:
> > Correct. And doing kfree(x); x=NULL; is not hiding that. These issues can still be debugged by
> > using the slab debugging options. One other benefit of doing this is that if someone tries to
> > access the same memory again using the variable 'x', then he will get an immediate crash.


What did you understand when I wrote that "if you access the same memory again using the variable
'x"?

Using variable 'x' means using variable 'x' and not variable 'y'.


 And
> the
> > problem can be solved immediately, without using the slab debugging options. I do not yet
> > understand how doing this hides the bugs, obfuscates the code, etc. because I haven't seen an
> > example yet, but only blanket statements.
> 
> char *broken() {
> 	char *x, *y;
> 	x = kmalloc(100);
> 	y = x;
> 	kfree(x);
> 	x = NULL;
> 	return y;
> }
> 
> Setting x to NULL doesn't do anything to fix the *real* bug here, because
> the problematic reference is held in y, not x.  


Did I ever say that it fixes that kind of bug?


>So you never get a crash
> because somebody dereferences x.
> 


Dereferencing 'x' means dereferencing 'x' and not dereferencing 'y'.

-Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
