Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbTI2I6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 04:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTI2I6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 04:58:25 -0400
Received: from aneto.able.es ([212.97.163.22]:33496 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262909AbTI2I6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 04:58:24 -0400
Date: Mon, 29 Sep 2003 10:58:07 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Frank Cusack <fcusack@fcusack.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2nd proc not seen
Message-ID: <20030929085807.GA22884@werewolf.able.es>
References: <20030904021113.A1810@google.com> <20030904091437.A25107@google.com> <20030928205045.B21288@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030928205045.B21288@google.com> (from fcusack@fcusack.com on Mon, Sep 29, 2003 at 05:50:46 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.29, Frank Cusack wrote:
> On Thu, Sep 04, 2003 at 09:14:37AM -0700, Frank Cusack wrote:
> > On Thu, Sep 04, 2003 at 02:11:13AM -0700, Frank Cusack wrote:
> > > I think I've seen some recent talk about this problem.  I have an HPAQ
> > > xw6000 w/ 2xP4 CPUs.  A RH kernel finds both CPUs (4 if I enable HT).  A
> > > kernel.org kernel only finds 1 (2 if I enable HT).
> 
> This turned out to be a CPU numbering issue.  The HPAQ machine numbers
> the cpus #0 and #6.  I had NR_CPUS set to 2.  That only works if the CPUs
> are physically numbered 0 and 1.
> 
> So NR_CPUS is a little misleading.  I could suggest a Config.help change
> if you like.
> 

This is a little weird. This forces you to have all the SMP structures sized
8 just to use 2 members.

Was not there a physical-logical map ? Or that was in -aa kernel and 2.6 ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre5-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
