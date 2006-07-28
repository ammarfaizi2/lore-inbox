Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWG1EEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWG1EEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 00:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWG1EEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 00:04:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:7400 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751733AbWG1EEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 00:04:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=KI5koMdUJly8FxexSAu6+CgKibHn+pTHfPURUKWyBDb219OkgFAvQo3YMlaLJPT8ic76dlOx7/gZ4aDbz3XpMe3cIfOLZVgv+Gc+J4J8lbKn8L7qtgZYZDh9BYRnawjfZnDAJINCXaqCOXBN2gpNre9U8ajd1hrZlmK/6On9x34=
Date: Fri, 28 Jul 2006 08:04:46 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alex Dubov <oakad@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
Message-ID: <20060728040446.GD5356@martell.zuzino.mipt.ru>
References: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 08:34:06PM -0700, Alex Dubov wrote:
> The driver is called tifmxx and available from:
> http://developer.berlios.de/projects/tifmxx/

1. Usual name for spinlocking flags is

	unsigned long flags;

2. Preferred CS for if statements is

	if (foo)
		bar; /* two lines no matter how short */

3. Check for NULL at the start of tifm_7xx1_remove is unnecessary.
   You've saved valid fm at probe time, right?

4. If ->suspend and ->resume are not implemented why add dummy ones?

5. 

