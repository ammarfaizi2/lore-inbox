Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268640AbTCCQ5z>; Mon, 3 Mar 2003 11:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268643AbTCCQ5z>; Mon, 3 Mar 2003 11:57:55 -0500
Received: from ausadmmsps306.aus.amer.dell.com ([143.166.224.101]:5137 "HELO
	AUSADMMSPS306.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S268640AbTCCQ5u>; Mon, 3 Mar 2003 11:57:50 -0500
X-Server-Uuid: c21c953d-96eb-4242-880f-19bdb46bc876
Message-ID: <20BF5713E14D5B48AA289F72BD372D680326F88E@AUSXMPC122.aus.amer.dell.com>
From: "Lerhaupt, Gary" <Gary_Lerhaupt@Dell.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [ANNOUNCE] DKMS: Dynamic Kernel Module Support
Date: Mon, 3 Mar 2003 11:07:03 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 127D5476642187-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to post a follow-up as I have seen only a few downloads of DKMS
since my original posting and also given that the Linux Development Group
here at Dell is very interested in feedback from the community.  The problem
of chasing kernel drops is a very real issue for Linux solution providers.
With our constant work with new hardware and large deployments involving
many customers, at times we simply cannot afford to wait for functional
drivers in the kernel.  This is especially true for the discovery and
resolution of high severity issues.  At the same time, we cannot just hand
updated source tarballs to our customers and expect that to be an
appropriate customer experience.  Further, it is just not feasible for us to
continue to produce kernel specific module RPMs for every kernel that we
support for every module that we support.

What is needed instead is a framework that can hold module source and can
recompile that source directly on user's systems for whichever kernel they
are running.  As well, this entire process must be non-painful.  We believe
that DKMS is this solution and we'd like to know if you agree and how it can
be improved.

Lastly, as I realize some might take a *don't care* approach to such a
problem given their personal Linux comfort level, I'd like to reiterate from
my previous post how such a framework could possibly yield benefits to the
entire process of Linux development.  We at Dell are very committed to
merging code into the kernel, and if a separate framework to deploy (and
test) module source existed apart from the kernel, we envision both an
improvement in the speed and quality of driver development that can later be
pushed back into the kernel.  

So, at your convenience we invite you to give DKMS a whirl (and to try out
the sample QLogic driver included for the full experience).  Thanks.

Gary Lerhaupt

> -----Original Message-----
> From: Lerhaupt, Gary 
> Sent: Friday, February 28, 2003 12:02 PM
> To: 'linux-kernel@vger.kernel.org'
> Subject: [ANNOUNCE] DKMS: Dynamic Kernel Module Support
> 
> 
> DKMS is a framework where device driver source can reside 
> outside the kernel source tree so that it is very easy to 
> rebuild modules as you upgrade kernels. This allows Linux 
> vendors to provide driver drops without having to wait for 
> new kernel releases (as a stopgap before the code can make it 
> back into the kernel), while also taking out the guesswork 
> for customers attempting to recompile modules for new kernels.
> 
> For veteran Linux users it also provides some advantages 
> since a separate framework for driver drops will remove 
> kernel releases as a blocking mechanism for distributing 
> code. Instead, driver development should speed up as this 
> separate module source tree will allow quicker testing cycles 
> meaning better tested code can later be pushed back into the 
> kernel at a more rapid pace. Its also nice for developers and 
> maintainers as DKMS only requires a source tarball in 
> conjunction with a small configuration file in order to 
> function correctly.
> 
> The latest DKMS version is available at 
> http://www.lerhaupt.com/dkms/.  It is licensed under the GPL. 
> You can also find a sample DKMS enabled QLogic RPM to show 
> you how it all works (or, a mocked-up tarball if you don't 
> like RPMs). If you use the sample RPM, you'll have to install 
> it with --nodeps as it requires the DKMS RPM to be installed 
> (which I haven't provided).
> 
> ===Using DKMS===
> 
> DKMS is one bash executable that supports 7 sub-actions: add, 
> build, install, uninstall, remove, status and match.
> 
> add: Adds an entry into the DKMS tree for later builds.  It 
> requires that source be located in 
> /usr/src/<module>-<module-version>/ as well as the location 
> of a properly formatted dkms.conf file (each dkms.conf is 
> module specific and is the configuration file that tells DKMS 
> how to build and where to install your module).
> 
> build: Builds your module but stops short of installing it.  
> The resultant .o files are stored in the DMKS tree.
> 
> install: Installs the module in the LOCATION specified in dkms.conf.
> 
> uninstall: Uninstalls the module and replaces it with 
> whatever original module was found during install (returns 
> your module to the "built" state).  
> 
> remove: Uninstalls and expunges all references of your module 
> from the DKMS tree.
> 
> status: Displays the current state (added, built, installed) 
> of modules within the DMKS tree as well as whether any 
> original modules have been saved for uninstallation purposes.
> 
> match: Allows you to take the configuration of DKMS installed 
> modules for one kernel and apply this config to some other 
> kernel.  This is helpful when upgrading kernels where you 
> would like to continue using your DKMS modules instead of 
> certain kernel modules.
> 
> Check out the man page for more details.
> 
> Gary Lerhaupt
> Linux Development
> Dell Computer Corporation
> 

