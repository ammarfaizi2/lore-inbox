Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWC1JRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWC1JRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWC1JRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:17:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38295 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751239AbWC1JRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:17:22 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, devel@openvz.org, serue@us.ibm.com,
       sam@vilain.net
Subject: Re: [RFC][PATCH 1/2] Virtualization of UTS
References: <44242B1B.1080909@sw.ru> <44242CE7.3030905@sw.ru>
	<m18xqzk6cy.fsf@ebiederm.dsl.xmission.com> <442449F8.4050808@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 27 Mar 2006 12:40:50 -0700
In-Reply-To: <442449F8.4050808@sw.ru> (Kirill Korotaev's message of "Fri, 24
 Mar 2006 22:35:20 +0300")
Message-ID: <m1bqvrekvx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>> This patch introduces utsname namespace in system, which allows to have
>>> different utsnames on the host.
>>> Introduces config option CONFIG_UTS_NS and uts_namespace structure for this.
>> Ok.  It looks like we need to resolve the sysctl issues before we merge
>> either patch, into the stable kernel.
> I disagree with you. Right now we can have sysctl and proc for init namespaces
> only.
> And when sysctl and proc are virtualized somehow, we can fix all these.
> I simply don't expect /proc and sysctl to be done quickly. As we have very
> different approaches. And there is no any consensus. Why not to commit
> working/agreed parts then?

So for planning purposes.  I don't think we can even if we ignore sysctl
and proc have an implementation that we all agree is stable and safe
before 2.6.17 merge window closes.  I do think if we get our act
together something that works and is tested when the 2.6.18 window
opens is very reasonable.  (Limited to UTS and sysvipc with other work
waiting until later).

Does that sound like a reasonable and achievable goal?

Eric
