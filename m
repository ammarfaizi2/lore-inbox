Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTHTBQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTHTBQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:16:46 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:51092
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261684AbTHTBQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:16:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O17int
Date: Wed, 20 Aug 2003 11:23:29 +1000
User-Agent: KMail/1.5.3
References: <200308200102.04155.kernel@kolivas.org> <yw1xn0e5lhz9.fsf@users.sourceforge.net>
In-Reply-To: <yw1xn0e5lhz9.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308201123.29206.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 02:39, Måns Rullgård wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> > Food for the starving masses.
> >
> > This patch prevents any single task from being able to starve the
> > runqueue that it's on. This minimises the impact a poorly behaved
> > application or a malicious one has on the rest of the system. If an
>
> I have to disagree.  Open a file of a few hundred lines in XEmacs and
> do a regexp search for "^[> ]*-*\n\\([> ]*.*\n\\)*[> ]*foo".  The
> system will more or less freeze.  It's a very nasty regexp, and it's
> an error to try to use it, but it still shouldn't freeze the system.

Reasonably sure this is a variation on the starvation which O17 won't address. 
Please top/vmstat/profile this and I'll look into it. There is potential for 
starvation without using up full timeslices and this may be it.

Con

