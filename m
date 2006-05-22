Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWEVQqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWEVQqe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWEVQqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:46:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58082 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750989AbWEVQqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:46:33 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<m1sln61jqs.fsf@ebiederm.dsl.xmission.com>
	<20060521162759.GA19707@sergelap.austin.ibm.com>
	<m1verzntca.fsf@ebiederm.dsl.xmission.com>
	<20060522121024.GB6025@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 May 2006 10:44:32 -0600
In-Reply-To: <20060522121024.GB6025@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Mon, 22 May 2006 07:10:24 -0500")
Message-ID: <m1wtceko0f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):

> Yup.
>
> Adding 7 extra void*'s seems to affect only dbench, which
> whose degration with the nsproxy falls outside the noise.
> The odd thing isn't so much the degradation, but the widely
> scattered values, compared to without nsproxy.

Well dbench is filesystem heavy so it may have some need to 
actually be using the filesystem namespace.  Although I can't
think of why it would.  Do you wan to track down that performance
regression or do you want to give up on that space optimization for
now?

Eric
