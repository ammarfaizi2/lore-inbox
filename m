Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWEEP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWEEP4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWEEP4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:56:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8587 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751133AbWEEP4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:56:48 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, herbert@13thfloor.at, dev@sw.ru,
       linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
References: <20060501203906.XF1836@sergelap.austin.ibm.com>
	<200605021930.45068.ak@suse.de>
	<20060503161143.GA18576@sergelap.austin.ibm.com>
	<200605051302.43019.ak@suse.de>
	<20060505114338.GA12850@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 05 May 2006 09:55:26 -0600
In-Reply-To: <20060505114338.GA12850@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Fri, 5 May 2006 06:43:38 -0500")
Message-ID: <m1d5es31qp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Ok.  Then I maintain that the bitmap of changed namespaces seems
> unnecessary.  Since you're likely sharing an nsproxy with your parent
> process, when you clone a new namespace you just want to immediately get
> a new nsproxy pointing to the new namespaces.
>
> Anyway this seems simple enough to just code up.  Simpler than
> continuing to talk about it  :)

For testing please include both uts and the filesystem namespace
in nsproxy.

That should give you at least one namespace that is frequently used.

Eric

