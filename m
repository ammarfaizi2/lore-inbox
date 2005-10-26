Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVJZRLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVJZRLf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVJZRLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:11:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:65240 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964832AbVJZRLe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:11:34 -0400
Message-ID: <5600736.1130346691049.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 26 Oct 2005 19:11:31 +0200 (CEST)
From: Andreas Kleen <ak@suse.de>
To: sekharan@us.ibm.com
Subject: Re: Notifier chains are unsafe
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
In-Reply-To: <1130284911.3586.152.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: SuSE Linux AG
References: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org> <p733bmp40yz.fsf@verdi.suse.de> <1130284911.3586.152.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi 26.10.2005 02:01 schrieb Chandra Seetharaman
<sekharan@us.ibm.com>:

> > Better would be likely to use RCU.
>
> RCU will be a problem if the registered notifiers need to block.
 
Actually blocking should be ok, as long as the blocking notifier doesn't
unregister
itself. The current next pointer will be always reloaded after the
blocking.
 
Still on preemptive kernels there might be problems, but they could
be likely solved by a few strategic preempt_disables in
notifier_call_chain().
 
Dipankar, what do you think?
 
-Andi
 

 

