Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVFMPXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVFMPXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVFMPXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:23:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61405 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261620AbVFMPVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:21:33 -0400
Date: Mon, 13 Jun 2005 16:22:35 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Horman <nhorman@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050613152235.GL24611@parcelfarce.linux.theplanet.co.uk>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com> <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk> <20050611193500.GC1097@devserv.devel.redhat.com> <20050612181006.GC2229@hmsendeavour.rdu.redhat.com> <1118670162.13250.25.camel@localhost.localdomain> <20050613135029.GC8810@hmsendeavour.rdu.redhat.com> <1118675421.13770.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118675421.13770.3.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:10:23PM +0100, Alan Cox wrote:
> On Llu, 2005-06-13 at 14:50, Neil Horman wrote:
> > You mean add the ability to monitor directories for changes to the ptrace
> > interface entirely?
> 
> If you are using it for debugging and tracking file accesses then ptrace
> seems to be the right interface. 

It all depends what you're trying to track.  If you want to ask what
"this task" is accessing, then yes, ptrace.  But if you want to know
who's chmod'ing /dev/null to 600 you really want a file- or directory-
based scheme.  Rather than extending F_NOTIFY, it might be better to
look at selinux policies?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
