Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRDTDSE>; Thu, 19 Apr 2001 23:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135790AbRDTDRy>; Thu, 19 Apr 2001 23:17:54 -0400
Received: from atlrel1.hp.com ([156.153.255.210]:10480 "HELO atlrel1.hp.com")
	by vger.kernel.org with SMTP id <S129245AbRDTDRv>;
	Thu, 19 Apr 2001 23:17:51 -0400
Date: Thu, 19 Apr 2001 21:17:49 -0600
To: "Eric S. Raymond" <esr@thyrsus.com>, Matthew Wilcox <willy@ldl.fc.hp.com>,
        linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010419211749.I4217@zumpano.fc.hp.com>
In-Reply-To: <20010419203639.H4217@zumpano.fc.hp.com> <20010419230009.A32500@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010419230009.A32500@thyrsus.com>; from esr@thyrsus.com on Thu, Apr 19, 2001 at 11:00:09PM -0400
From: willy@ldl.fc.hp.com (Matthew Wilcox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 11:00:09PM -0400, Eric S. Raymond wrote:
> What is the right procedure for doing changes like this?  Is "don't
> touch that tree" a permanent condition, or am I going to get a chance
> to clean up the global CONFIG_ namespace after your next merge-down?

Our current status is that we've got a patch with Alan that's been sitting
in his tree for a while (things got trickier than he expected and he
hasn't been able to merge that upstream to Linus yet).  Meanwhile we've
carried on development as normal.  So even after the patches in Alan's
tree land, we've still got a fair hunk of changes to go in.

My preference would be for you to fetch our tree 

cvs -d :pserver:anonymous@puffin.external.hp.com:/home/cvs/parisc login
[no password]

cvs -d :pserver:anonymous@puffin.external.hp.com:/home/cvs/parisc co linux

and submit patches to us, which will get to Linus in the fullness of time.
I'm aware this might not be terribly satisfactory for you, but we're
doing our best not to lose our way amid the churn of development right
now and having patches which haven't followed a progression through
us makes that significantly harder.

> Could I ask you to audit your tree and change the prefix on any 
> CONFIG_ symbols that are private over there?  This would make life 
> easier for my auditing tools (kxref and Stephen Cole's ach script).

I don't think we have any of those.  We certainly have symbols which are
defined for symmetry and may not actually be used yet (CONFIG_PA11 might not
be, perhaps).  But that's what happens when you're developing software :-)

