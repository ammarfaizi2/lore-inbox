Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267769AbUG3SPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267769AbUG3SPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 14:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUG3SPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 14:15:11 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:42247 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267769AbUG3SNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 14:13:20 -0400
Date: Fri, 30 Jul 2004 20:16:36 +0200
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: symlinks follow 8 or 5?
Message-ID: <20040730181636.GA13434@hh.idb.hist.no>
References: <1091079278.1999.5.camel@localhost.localdomain> <slrn-0.9.7.4-22364-14114-200407301259-tc@hexane.ssi.swin.edu.au> <1091171770.2794.4.camel@laptop.fenrus.com> <410A7A86.6030206@redhat.com> <20040730165151.GA11967@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730165151.GA11967@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040523i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 06:51:53PM +0200, Arjan van de Ven wrote:
> On Fri, Jul 30, 2004 at 09:42:46AM -0700, Ulrich Drepper wrote:
> > 
> > Which reminds me: how can we safely determine whether this is
> > implemented for a local filesystem from userland?  Unless we can do I
> > cannot change the value of SYMLOOP_MAX and people will not be able to
> > take advantage of the raised limit safely.
> 
> well actually it can't be per userland; it's just that we're almost at the
> point where all filesystems are switched to the new infrastructure so that
> the global constant can be bumped to 8 again...

Well, one can test it from userland - make a tempdir and create progressively
longer link chains until it fails.  Quirky, sure.

Helge Hafting

