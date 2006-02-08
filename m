Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWBHSDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWBHSDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWBHSDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:03:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52693 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030289AbWBHSDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:03:17 -0500
Date: Wed, 8 Feb 2006 12:03:09 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208180309.GA20418@sergelap.austin.ibm.com>
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <m1ek2ea0fw.fsf@ebiederm.dsl.xmission.com> <43EA02D6.30208@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EA02D6.30208@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hubertus Franke (frankeh@watson.ibm.com):
> IMHO, there is only a need to refer to a namespace from the global context.
> Since one will be moving into a new container, but getting out of one
> could be prohibitive (e.g. after migration)
> It does not make sense therefore to know the name of a namespace in
> a different container.

Not sure I agree.  What if we are using a private namespace for a
vserver, and then we want to create a private namespace in there for a
mobile application.  Since we're talking about nested namespaces, this
should be possible.

Now I believe Eric's code so far would make it so that you can only
refer to a namespace from it's *creating* context.  Still restrictive,
but seems acceptable.

(right?)

-serge
