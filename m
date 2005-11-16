Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVKPMIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVKPMIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVKPMIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:08:53 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:11943
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030281AbVKPMIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:08:53 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [RFC] sys_punchhole()
Date: Wed, 16 Nov 2005 06:08:18 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, andrea@suse.de, hugh@veritas.com,
       linux-mm@kvack.org
References: <1131664994.25354.36.camel@localhost.localdomain> <20051110153254.5dde61c5.akpm@osdl.org> <200511110925.48259.ioe-lkml@rameria.de>
In-Reply-To: <200511110925.48259.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160608.18413.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 02:25, Ingo Oeser wrote:
> Hi,
>
> On Friday 11 November 2005 00:32, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > We discussed this in madvise(REMOVE) thread - to add support
> > > for sys_punchhole(fd, offset, len) to complete the functionality
> > > (in the future).

You know, if you wanted to get really really gross and disgusting about this, 
you could always have write(fd, NULL, count) punch a hole in the file.  (Then 
have libc's write() check for NULL and error out, and have a seprate punch() 
call that does the write with the null...)

Just one way to avoid introducing a new syscall...

Rob
