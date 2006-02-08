Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030612AbWBHUoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030612AbWBHUoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030615AbWBHUoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:44:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:28307 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030612AbWBHUoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:44:38 -0500
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       clg@fr.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, kuznet@ms2.inr.ac.ru,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>
In-Reply-To: <43EA1008.5040502@sw.ru>
References: <43E7C65F.3050609@openvz.org>
	 <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	 <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	 <43EA1008.5040502@sw.ru>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 12:43:55 -0800
Message-Id: <1139431435.9452.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 18:36 +0300, Kirill Korotaev wrote: 
> - full isolation can be inconvinient from containers management point of 
> view. You will need to introduce new modified tools such as top/ps/kill 
> and many many others. You won't be able to strace/gdb processes from the 
> host also. 

I'd like to put a theory out there:  the more isolation we perform, the
easier checkpointing and migration become to guarantee.

Agree?  Disagree?

But, full isolation is hard to code.  The right approach is very likely
somewhere in the middle where we require some things to happen
underneath us.  For instance, requiring that the filesystem be made
consistent if a container is moved across systems.

-- Dave

