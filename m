Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWHPQen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWHPQen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWHPQen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:34:43 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:8607 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932106AbWHPQem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:34:42 -0400
Date: Wed, 16 Aug 2006 18:27:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Hansen <haveblue@us.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, containers@lists.osdl.org,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH 5/7] pid: Implement pid_nr
In-Reply-To: <1155667063.12700.56.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0608161826580.23266@yvahk01.tjqt.qr>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> 
 <1155666193751-git-send-email-ebiederm@xmission.com>
 <1155667063.12700.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static inline pid_t pid_nr(struct pid *pid)
>> +{
>> +       pid_t nr = 0;
>> +       if (pid)
>> +               nr = pid->nr;
>> +       return nr;
>> +} 
>
>When is it valid to be passing around a NULL 'struct pid *'?

Is 0 even the right thing to return in the rare case that pid == NULL?
-1 maybe?


Jan Engelhardt
-- 
