Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270649AbRH1KuQ>; Tue, 28 Aug 2001 06:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270661AbRH1Kt4>; Tue, 28 Aug 2001 06:49:56 -0400
Received: from ns.suse.de ([213.95.15.193]:53000 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270649AbRH1Kts>;
	Tue, 28 Aug 2001 06:49:48 -0400
Date: Tue, 28 Aug 2001 12:50:03 +0200
From: Andi Kleen <ak@suse.de>
To: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>
Cc: Andi Kleen <ak@suse.de>, Hans Reiser <reiser@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Journal Filesystem Comparison on Netbench
Message-ID: <20010828125003.A27996@gruyere.muc.suse.de>
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com.suse.lists.linux.kernel> <3B8AA7B9.8EB836FF@namesys.com.suse.lists.linux.kernel> <oupsneck77v.fsf@pigdrop.muc.suse.de> <3B8B755F.D6317A9A@crm.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8B755F.D6317A9A@crm.mot.com>; from Emmanuel_Varagnat-AEV010@email.mot.com on Tue, Aug 28, 2001 at 12:41:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 12:41:35PM +0200, Emmanuel Varagnat wrote:
> 
> Andi Kleen wrote:
> > 
> > It does not really look like a locking problem. If you look at the profiling
> > logs it is pretty clear that the problem is the algorithm used in
> > bitmap.c:find_forward. find_forward and reiserfs_in_journal
> > ...
> > journaled blocks set also, to quickly skip them for the common case.
> 
> I'm very interested in the way you did profiling.
> Did you compile the kernel with profiling options (gprof ?) ?
> If so, where the profiling information file is saved ?

I did not do any profiling in this case; I just read an existing log.
If you want to do profiling yourself you could use the simple 
builtin statistical profiler: boot with profile=2 on the command line
and read the log at anytime using the readprofile command.
Other ways are documented on the lse homepage http://lse.sourceforge.net

-Andi
