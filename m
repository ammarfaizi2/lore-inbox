Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDSRT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDSRT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDSRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:19:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:15769 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751123AbWDSRT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:19:26 -0400
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
In-Reply-To: <m1u08pld7d.fsf@ebiederm.dsl.xmission.com>
References: <20060407095132.455784000@sergelap>
	 <20060407183600.E40C119B902@sergelap.hallyn.com> <4446547B.4080206@sw.ru>
	 <20060419152129.GA14756@sergelap.austin.ibm.com>
	 <m1bquxmuk5.fsf@ebiederm.dsl.xmission.com>
	 <1145463814.31812.13.camel@localhost.localdomain>
	 <m1u08pld7d.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 10:19:18 -0700
Message-Id: <1145467159.31812.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:52 -0600, Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > Besides ipc and utsnames, can anybody think of some other things in
> > sysctl that we really need to virtualize?
> 
> All of the networking entries.
...
> Only in that you attacked the wrong piece of the puzzle.
> The strategy table entries simply need to die, or be rewritten
> to use the appropriate proc entries.

If we are limited to ipc, utsname, and network, I'd be worried trying to
justify _too_ much infrastructure.  The network namespaces are not going
to be solved any time soon.  Why not have something like this which is a
quite simple, understandable, minor hack?

> The proc entries are the real interface, and the two pieces
> don't share an implementation unfortunately.

You're saying that the proc interface doesn't use the ->strategy entry?
That isn't what I remember, but I could be completely wrong.

-- Dave

