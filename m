Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUIJLAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUIJLAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 07:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUIJLAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 07:00:44 -0400
Received: from open.hands.com ([195.224.53.39]:8168 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267359AbUIJLAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 07:00:35 -0400
Date: Fri, 10 Sep 2004 12:11:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040910111146.GF14060@lkcl.net>
References: <20040908100946.GA9795@lkcl.net> <20040908103922.GD9795@lkcl.net> <1094802568.8495.49.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094802568.8495.49.camel@sherbert>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 08:49:28AM +0100, Gianni Tedesco wrote:
> On Wed, 2004-09-08 at 11:39 +0100, Luke Kenneth Casson Leighton wrote:
> > ... did i sent a patch?
> > 
> > did i send a patch??  i don't _think_ so *lol* :)
> 
> heh :)
> 
> IMO the number of constraints involed here make using this patch fairly
> involved (for something security related at least) in that, as you said,
> you have to:
> 
>  - be careful to use ACCEPT rules only
>  - be careful that you do:
>     1. remove fw rules
>     2. upgrade software
>     3. replace rules
> 
> plus the fastpath code looks very hairy with at least 3 locks taken and
> O(num_tasks * max_fds) unpreemptable in softirq...
 
 it's no worse than the present fireflier solution, which on a
 per-packet basis in userspace will go hunting through /proc
 looking for the socket _that_ way *gibber*.

 fireflier reads /proc/NNNN/exe, then also hunts through the fds for
 that process on /proc looking for things beginning with "socket:".

 [actually it used not to bother with the qualification for "socket:"
  resulting in a complete nightmare time for creating appropriate
  selinux policy]

 l.

