Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132688AbRDQOg4>; Tue, 17 Apr 2001 10:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRDQOgq>; Tue, 17 Apr 2001 10:36:46 -0400
Received: from ns.suse.de ([213.95.15.193]:39183 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132664AbRDQOgZ>;
	Tue, 17 Apr 2001 10:36:25 -0400
Date: Tue, 17 Apr 2001 16:36:23 +0200
From: Andi Kleen <ak@suse.de>
To: Maneesh Soni <smaneesh@in.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, Paul.McKenney@us.ibm.com,
        dipankar@sequent.com, lkml <linux-kernel@vger.kernel.org>,
        lse tech <lse-tech@lists.sourceforge.net>
Subject: Re: Scalable FD Management ....
Message-ID: <20010417163623.A9336@gruyere.muc.suse.de>
In-Reply-To: <20010409201311.D9013@in.ibm.com> <20010411182929.A16665@va.samba.org> <20010412211354.A25905@in.ibm.com> <20010412085118.A26665@va.samba.org> <20010417161916.A11419@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010417161916.A11419@in.ibm.com>; from smaneesh@in.ibm.com on Tue, Apr 17, 2001 at 04:19:16PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 04:19:16PM +0530, Maneesh Soni wrote:
> But still the throughput improvement is not there for my patch. the reason, I 
> think, is that I didnot get too many hits to fget() routine. It will be helpful
> if you can tell how you got fget() chewing up more than its fair share of CPU
> time.

dbench uses fork(), not clone, and therefore has no shared file_structs that
could be contended.


-Andi
