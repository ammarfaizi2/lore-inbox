Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263219AbRFLUXE>; Tue, 12 Jun 2001 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263225AbRFLUWy>; Tue, 12 Jun 2001 16:22:54 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58418
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S263219AbRFLUWr>; Tue, 12 Jun 2001 16:22:47 -0400
Date: Tue, 12 Jun 2001 22:22:18 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Disconnect <lkml@sigkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rsync hangs on RedHat 2.4.2 or stock 2.4.4
Message-ID: <20010612222218.F1161@jaquet.dk>
In-Reply-To: <Pine.LNX.4.33.0106121417130.10732-100000@xpc1.ast.cam.ac.uk> <20010612154735.B17905@flint.arm.linux.org.uk> <15142.11907.782662.581523@pizda.ninka.net> <20010612112302.A16949@sigkill.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010612112302.A16949@sigkill.net>; from lkml@sigkill.net on Tue, Jun 12, 2001 at 11:23:02AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 11:23:02AM -0400, Disconnect wrote:
> On Tue, 12 Jun 2001, David S. Miller did have cause to say:
> 
> > Look everyone, it was determined to be a deadlock because of some
> > interaction between how rsync sets up it's communication channels
> > with the ssh subprocess, readas: userland bug.
> 
> ....we're not using ssh. :(

Neither am/was I. The rsync is within a single FS.

Aside from that, here is the original bug report by Matthias 
Schniedermeyer: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=98157768131423&w=2
with no reply.

My report:
http://marc.theaimsgroup.com/?l=linux-kernel&m=98262067309185&w=2
with myself replying :) 

Russell King's report: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=98326853429463&w=2
which gave a fair amount of discussion.

Note that in my report I state that the problem cannot be seen
with smaller workloads; I have to try with at least drivers/*
before it shows itself. Hmm, just tried with 243-ac12 (yeah,
I'm way behind). I have to try the full tree now, drivers/*
wont do it anymore.
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"An intellectual is someone who has been educated beyond their intelligence."
