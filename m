Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVL1Ipw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVL1Ipw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVL1Ipv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:45:51 -0500
Received: from main.gmane.org ([80.91.229.2]:11678 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932518AbVL1Ipv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:45:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Shaun" <mailinglists@unix-scripts.com>
Subject: Memory, where's it going?
Date: Wed, 28 Dec 2005 00:45:29 -0800
Message-ID: <dotjb6$j8$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-111-70-41.oc.oc.cox.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-RFC2646: Format=Flowed; Original
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server with 8GB of RAM thats running 2.6.14.3 with the UML Ska's 3 
Patch.   It seams the system is eating more and more memory everyday but i 
cant seam to figure out where it's going.

I free shows the following...
[root@hostXXX ~]# free
             total       used       free     shared    buffers     cached
Mem:       8312484    8040500     271984          0     120664    7734420
-/+ buffers/cache:     185416    8127068
Swap:      4192924       2500    4190424

I see that free shows that 7.7GB is cached and i'm not sure why so much is 
cached.

When running through a ps auxf grabbing VSZ and RSS i get the following 
results...

For VSZ...
[root@hostXXX ~]# TOTAL=0;for i in `ps auxf|awk '{print $5}'`;do TOTAL=$(($i 
+ $TOTAL));done;echo $TOTAL
2459016

For RSS...
[root@hostXXX ~]# TOTAL=0;for i in `ps auxf|awk '{print $6}'`;do TOTAL=$(($i 
+ $TOTAL));done;echo $TOTAL
2239188

Anybody have any idea what is going on here?

-- 

~Shaun 



