Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWBHTYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWBHTYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWBHTYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:24:55 -0500
Received: from hera.kernel.org ([140.211.167.34]:13028 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932489AbWBHTYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:24:53 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
Date: Wed, 8 Feb 2006 11:24:25 -0800
Organization: OSDL
Message-ID: <20060208112425.1e25d012@dxpl.pdx.osdl.net>
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net>
	<43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<43E92EDC.8040603@watson.ibm.com>
	<20060208004325.GA15061@ms2.inr.ac.ru>
	<m1k6c6bm57.fsf@ebiederm.dsl.xmission.com>
	<20060208033633.GA8784@sergelap.austin.ibm.com>
	<m1d5hybj80.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1139426665 30056 10.8.0.74 (8 Feb 2006 19:24:25 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 8 Feb 2006 19:24:25 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Feb 2006 20:52:15 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> >
> > What I tried to do in a proof of concept long ago was to have
> > CLONE_NETNS mean that you get access to all the network devices, but
> > then you could drop/add them.  Conceptually I prefer that to getting an
> > empty namespace, but I'm not sure whether there's any practical use
> > where you'd want that...
> 
> My observation was that the network stack does not come out cleanly
> as a namespace unless you adopt the rule that a network device
> belongs to exactly one network namespace.
> 
> With that rule dealing with the network stack is just a matter of making
> some currently global variables/data structures per container.
> 
> A pain to do the first round but easy to maintain once you are there
> and the logic of the code doesn't need to change.
> 
> Eric

Since a major change risks breaking lots of stuff you would need to have
a complete test suite that could be run to show you didn't break anything.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
