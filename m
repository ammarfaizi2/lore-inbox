Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTEMMUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTEMMUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:20:36 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:65206 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S263655AbTEMMUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:20:34 -0400
Date: Tue, 13 May 2003 08:31:06 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <Valdis.Kletnieks@vt.edu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052774389.31825.21.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0305130809520.5520-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 May 2003, Alan Cox wrote:

> On Llu, 2003-05-12 at 23:12, Valdis.Kletnieks@vt.edu wrote:
> > In particular, the code that handles the zeroing out of resource objects
> > before re-use needs to be "inside" the trusted-base perimeter.  This has
> > been well-understood for years - even my August 83 copy of the Orange Book
> > says (for class C2):
>
> 1. Base Linux is not C2 certified

No but it can be, provided appropriate steps are taken on the system,
without recoding the kernel become C2 certified.  C2 is not mandatory
access control, it is still in the realm of discretionary access control.
According to the orange book standard, it's the highest DAC standard.

> 2. C2 is obsolete

Or in Common Criteria Equivalence, achieve EAL3 in various system security
classes.  No labelled security classes would be required.

> 3. NSA SELinux can do the needed stuff from scanning the code

Yes but SELinux is not an attempt to get C2 ... it is more to try and get
B1 equivalence (Labelled security) however B1 by itself is no good because
it doesn't secure against the security officer itself, which is a
desirable feature in order to achieve EAL4 for labeled security under
common-criteria.

Linux kernel, as a whole, will not meet the EAL4 requirements as it
stands, because it is not documented as per the EAL4 code documentation
standard. This is from my direct discussions with two independent CC
evaluation laboritory top technical advisors.  The sheer size of the linux
kernel code, and the speed at which it develops and enhances, makes it a
bad candidate.

> 4. Even then data erasure is not guaranteed because of the drive logic

Data-erasure is not a requirement to ensure a trusted-operating system, if
it can be demonstrated that on a running system no one except the
kernel-user can get access to the swap information.  If along with this it
can be proven (certified really) that the phyiscal security of the system
meets a certain level of assurance then you can consider the environment
trusted.

> So you are back to crypting swap in the first place
>

But isn't swap crypting fun ? :-) Running encrypted swap is okay so long
as we throw away the key after each session.  This can be easily (famous
last words) achieved under crypto kernels. I am not certain if such
functionaility is being contemplated for the Linux kernel along with the
new cryptoloop stuff, if there isn't i can volunteer to put something like
that in - if we are interested. Are we?

Cheers,

Ahmed.

