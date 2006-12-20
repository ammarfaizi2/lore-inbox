Return-Path: <linux-kernel-owner+w=401wt.eu-S965062AbWLTNsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWLTNsN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWLTNsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:48:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55580 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965059AbWLTNsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:48:11 -0500
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
From: Arjan van de Ven <arjan@infradead.org>
To: David Wragg <david@wragg.org>
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       bcrl@kvack.org
In-Reply-To: <878xh2aelz.fsf@wragg.org>
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	 <878xh2aelz.fsf@wragg.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 14:48:06 +0100
Message-Id: <1166622487.3365.1386.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 13:20 +0000, David Wragg wrote:
> "Albert Cahalan" <acahalan@gmail.com> writes:
> > On Mon, Dec 18, 2006 at 11:50:08PM +0000, David Wragg wrote:
> >> This patch (against 2.6.19/2.6.19.1) adds the four context
> >> switch values (voluntary context switches, involuntary
> >> context switches, and the same values accumulated from
> >> terminated child processes) to the end of /proc/*/stat,
> >> similarly to min_flt, maj_flt and the time used values.
> >
> > Hmmm, OK, do people have a use for these values?
> 
> My reason for writing the patch was to track which processes are
> active (i.e. got scheduled to run) by polling these context switch
> values.  The time used values are not a reliable way to detect process
> activity on fast machines.  So for example, when sorting by %CPU, top
> often shows many processes using 0% CPU, despite the fact that these
> processes are running occasionally.  If top sorted by (%CPU, context
> switch count delta), it might give a more useful display of which
> processes are active on the system.


if all you care is the number of context switches, you can use the
following system tap script as well:

http://www.fenrus.org/cstop.stp


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

