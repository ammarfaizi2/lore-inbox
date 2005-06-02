Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVFBGcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVFBGcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 02:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFBGcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 02:32:41 -0400
Received: from main.gmane.org ([80.91.229.2]:5254 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261580AbVFBGcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 02:32:39 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Amit Shah <shahamit@gmail.com>
Subject: Re: [PATCH] Sample fix for hyperthread exploit
Followup-To: gmane.linux.kernel
Date: Thu, 02 Jun 2005 11:58:45 +0530
Message-ID: <d7m8u0$ivc$1@sea.gmane.org>
References: <200506012158.39805.kernel@kolivas.org> <1117627597.6271.29.camel@laptopd505.fenrus.org> <200506012213.25445.kernel@kolivas.org> <20050601172505.GM23013@shell0.pdx.osdl.net> <1117654147.6271.38.camel@laptopd505.fenrus.org> <20050602024924.GD27174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 202.75.194.254
User-Agent: KNode/0.9.0
Cc: ck@vds.kolivas.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> 
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
>> > Also, uid is not sufficient.  Something more comprehensive (like
>> > ability to ptrace) would be appropriate.
>> 
>> I would go a lot simpler. App says "I want exclusivity" via pctl and
>> NOTHING runs on the other half. Well maybe with exceptions of
>> processes that share the mm with the exclusive one (in practice
>> "threads") since those could just read the memory anyway.
> 
> this has the disadvantage of needing changes in the security apps.
> Basing this off the uid (or the ability to ptrace) makes it at least
> automatic - but introduces a permanent penalty not only on multiuser
> boxes, but on basically any server box that runs multiple services.

Can this be not limited to just not running any other process on the same
(SMT-enabled) processor (precondition being ability to ptrace)?

Amit.
-- 
Amit Shah
http://amitshah.net/

