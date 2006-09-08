Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWIHN20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWIHN20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 09:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWIHN2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 09:28:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41858 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751103AbWIHN2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 09:28:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table driven.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<20060907101512.3e3a9604.akpm@osdl.org>
	<Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr>
	<m11wqmmxfw.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0609081507330.20566@yvahk01.tjqt.qr>
Date: Fri, 08 Sep 2006 07:27:22 -0600
In-Reply-To: <Pine.LNX.4.61.0609081507330.20566@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Fri, 8 Sep 2006 15:08:48 +0200 (MEST)")
Message-ID: <m1fyf2lc91.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>>>> +	for (; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
>>>>
>>> Also works without the () around ARRAY_SIZE(..)-1
>>
>>Sure.  But I don't really trust C precedence (because it is wrong)
>
> Wrong? In mathematics, "a < (b - 1)" also is equivalent to "a < b - 1".

In mathematics < is not an operation that yields a result in
the domain of integers.  So  "(a < b) - 1" is impossible.

Regardless this isn't a case where the C precedence is wrong.
"a < b | 1" is an example of C getting the precedence wrong.

Having to remember where C is wrong and in what circumstances is
harder than just putting in parenthesis.

Eric
