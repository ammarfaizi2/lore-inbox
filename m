Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVBYSbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVBYSbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVBYSbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:31:03 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:60127 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262766AbVBYSbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:31:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:organization:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GGm2/x0pOo5wCEUgNTBXoUP2ApdWZJzmgFDF/vpEd/jVzvq9D/BwH/rLdj8NbviFR0yAOu17v07bgutOUX2idwbe4A8s0SdaOhnwmQesMLjExmvRiKJKxeEep+0KZCSRQ3f84KMy4l2dn1dB70Ki/G2ImsD1q8DdFydkRtLlFSs=
From: Vicente Feito <vicente.feito@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: oom_killer.c - oom_kill_task and __oom_kill_task question
Date: Fri, 25 Feb 2005 15:32:42 +0000
User-Agent: KMail/1.7.1
Organization: none
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502251532.42819.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is it that p->mm it's checked inside oom_kill_task and again in 
__oom_kill_task? Cause __oom_kill_task it's called in case p->mm not null and 
not &init_mm, otherwise it just returns NULL, this has been bothering me, 
I've patched with the last rc5 and it's still there, why?
Is there a chance a process can grow an mm area between one call and another?

Vicente.
