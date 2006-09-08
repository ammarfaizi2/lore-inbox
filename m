Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752026AbWIHBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWIHBbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbWIHBbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 21:31:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:56002 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752026AbWIHBbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 21:31:38 -0400
Date: Thu, 7 Sep 2006 20:31:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908013136.GA20535@sergelap.austin.ibm.com>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr> <20060907230245.GB21124@sergelap.austin.ibm.com> <20060908010802.GA14770@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908010802.GA14770@clipper.ens.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Madore (david.madore@ens.fr):
> My patch doesn't change any of this (I've checked), since it uses
> inheritance rules for capabilities which are closely modeled upon
> those of {r,s,e}uid (in fact, that's my very reason for "changing"
> things), and since the bash method of dropping privileges is also kept
> woring.

Ah, ok.  So there is in fact no change in setuid behavior at all then.

Do you have a little testsuite you've run which you could make available
someplace?  Or a few test programs you could toss into a tarball and
call a testsuite?  :)

> (b) necessary for security reasons (it is imperative that the parent
> of a suid root process cannot prevent that process from keeping
> privileges, otherwise we get the sendmail bug again).

Good point.

> To summarize my answer: as far as I know, my patch does not change
> suid behavior: I've taken great care not to let that happen.  It does
> change the documented inheritance behavior of capabilities, but that
> is unavoidable.
> 
> PS: I should be releasing a new version of my patch, along with a
> merged version of yours, very shortly.

Could you cc: the lsm list (linux-security-module@vger.kernel.org)?
I'd particularly have Chris Wright give some comment as he's spent a
lot of time looking at capabilities.

thanks,
-serge
