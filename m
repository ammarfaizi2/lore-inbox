Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUGYTot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUGYTot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 15:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUGYTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 15:44:49 -0400
Received: from main.gmane.org ([80.91.224.249]:23751 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264305AbUGYTor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 15:44:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: [PATCH] Delete cryptoloop
Date: Sun, 25 Jul 2004 19:44:41 +0000 (UTC)
Message-ID: <loom.20040725T212435-197@post.gmane.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <1090672906.8587.66.camel@ghanima> <41039CAC.965AB0AA@users.sourceforge.net> <1090761870.10988.71.camel@ghanima> <4103ED18.FF2BC217@users.sourceforge.net> <1090778567.10988.375.camel@ghanima>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.128.251.122 (Mozilla/5.0 (compatible; Konqueror/3.2; Linux) (KHTML, like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens <clemens-dated-1091642568.f246 <at> endorphin.org> writes:  
  
>   
> That's no exploit. Where is the exploit?  
> http://www.google.com/search?q=jargon%20exploit   
> When you're there, you can look up the term ``backdoor'' as well.   
  
We can, of course, discuss terminology, yet the problem remains the same. 
  
>   
> Probably I'm missing the point, but at the moment this looks like a  
> chosen plain text attack. As you know for sure, this is trivial. For  
> instance, AES asserts to be secure against this kind of attack. (See the  
> author's definition of K-secure..).  
  
It assures against key revovery through chosen plain text attacks. As written 
before, the purpose of this attack is not to break encryption, but to prove 
the existence of a file *known to* and *prepared by* the attacker.  
  
The exploit generates a rather simple bit pattern with a size of 1024 bytes.  
When this pattern - the watermark - is encrypted, dm-crypt's output has some  
special properties - independent of cipher or key size.  
For example, encoding nr. 1, always produces a cyphertext block, where bytes  
0-15 are equal to bytes 512-523.  
  
If you cannot believe this, please try yourself. I did so a few hours ago.  
  
On dm-crypt's mailing list, I have given a description how this can be refined  
easily to improve reliability of detection and determine a file's layout on 
the encrypted volume.  
  
Regards  
  
  
  

