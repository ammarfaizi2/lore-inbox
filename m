Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVCWT5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVCWT5c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVCWT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:57:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61847 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262020AbVCWT5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:57:16 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	<1111552017.3604.78.camel@localhost.localdomain>
	<1111574173.4756.20.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2005 12:54:05 -0700
In-Reply-To: <1111574173.4756.20.camel@localhost.localdomain>
Message-ID: <m18y4ervdu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Wed, 2005-03-23 at 13:26 +0900, Fernando Luis Vazquez Cao wrote:
> > Hi all.
> > 
> > On Tue, 2005-03-08 at 18:20 +0530, vivek goyal wrote:
> > > Core image ELF headers are prepared before crash and stored at a safe
> > > place in memory. These headers are retrieved over a kexec boot and final
> > > elf core image is prepared for analysis. 
> > 
> > Regarding the preparation of the ELF headers, I think we should also
> > take into consideration hot-plug memory and create appropriate
> > mechanisms to deal with it.
> > 
> > Assuming that both insertion and removal of memory trigger a hotplug
> > event that is subsequently handled by the relevant hotplug agent(*), the
> > latter could be modified so that, on successful memory onlining,
> > additional PT_LOAD headers are created and tucked in a safe place
> > together with the others.
> 
> I think, re-loading the panic kernel in such event should be an easier
> solution. Current kexec system call interface does not allow to read
> back already stored segments, which is necessary to append new PT_LOAD
> headers to the existing program header list and update ELF header.

I thought that is what he was describing.

Eric
