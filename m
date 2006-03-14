Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWCNWkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWCNWkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNWkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:40:40 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:7367 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751944AbWCNWkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:40:39 -0500
Date: Tue, 14 Mar 2006 23:40:37 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>,
       "Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question: pid space semantics.
Message-ID: <20060314224037.GA1843@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kirill Korotaev <dev@sw.ru>,
	"Dave Hansen <haveblue@us.ibm.com> Cedric Le Goater" <clg@fr.ibm.com>,
	linux-kernel@vger.kernel.org
References: <1142282940.27590.17.camel@localhost.localdomain> <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 11:43:38AM -0700, Eric W. Biederman wrote:
> 
> To retain any part of the existing unix process management
> we need some processes that show up in multiple pid spaces.

hmm ... not sure about that, what 'we' need is a way
to move between pid spaces and to control processes
in a child space from the parent process ...

nevertheless I don't think we have a problem with
schizophrenic processes if they have a somewhat sane
*G* interface/view into both spaces ...

> To allow for migration it must be possible for the pids in 
> those pid spaces to be different.

I take that as migration of a 'container' from one
system to another, not as 'migration' between spaces

I don't understand what you mean here, please elaborate

> It is undesirable in the normal case of affairs to allocate more
> than one pid per process.
> 
> Given the small range of pid values these constraints make an
> efficient and general pid space solution challenging.
> 
> The question:
>   If we could add additional pid values in different pid spaces 
>   to a process with a syscall upon demand would that lead to an
>   implementation everyone could use? 

again, for what would I need a 'second' or 'third' pid
value for a process either on demand or permanent for
handling or migration?

> I assume most processes by default only have a pid value in 
> a single pid space.
> 
> The reason I ask is that I believe I know how to implement 
> a cheap general mechanism for adding additional pids to a 
> process.

I have the feeling this is going into a completely wrong
direction, what am I missing here?

TIA,
Herbert

> Eric
