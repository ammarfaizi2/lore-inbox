Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWHELrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWHELrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWHELrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:47:20 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:22625 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161275AbWHELrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:47:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=NSvPqSAAwtF1tix+0Encn+LQ1MyDBFr28hszQh5M5Hsa88lgqizL+mgwyXEMooY8o3iQ0dQpOG4lA/yCGXivcRBZys/T4gix4kFIdSLJ9ZkOa3tUzYVjEUlgvNYSsJp+afaA+fxsaZdmsbdeCEsZx/gWqUKnQpnjHmWKzAshRE0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net, sandr8@gmail.com
Subject: Re: [uml-devel] [PATCH 10/19] UML - Remove spinlock wrapper functions
Date: Sat, 5 Aug 2006 13:47:26 +0200
User-Agent: KMail/1.9.1
Cc: "Jeff Dike" <jdike@addtoit.com>, linux-kernel@vger.kernel.org
References: <200607070033.k670XhQR008707@ccure.user-mode-linux.org> <517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
In-Reply-To: <517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608051347.26926.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 August 2006 15:00, alessandro salvatori wrote:
> Jeff,
>
>    the new lock irq_lock is still static, but we now have preprocessor
> macros to be included from a header file

Are you talking about spin_lock_irqsave & co? In that case you have maybe 
missed that the removed functions were simply wrappers for spin_lock_irqsave. 
Those wrappers existed to be used in files which can't include kernel headers 
(long story).

> instead of non-static functions in 
> the same module as the static irq_lock.

> Am I missing something?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
