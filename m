Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVETTxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVETTxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVETTxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:53:42 -0400
Received: from MINBAR.FAC.CS.CMU.EDU ([128.2.185.161]:12681 "HELO
	minbar.fac.cs.cmu.edu") by vger.kernel.org with SMTP
	id S261559AbVETTxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:53:40 -0400
Date: Fri, 20 May 2005 15:53:07 -0400
From: Jeffrey Hutzelman <jhutz@cmu.edu>
To: ted creedon <tcreedon@easystreet.com>
cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same
 for 2.4.30 and openafs 1.3.82
Message-ID: <2D6D4407013EDC38C0E580C0@sirius.fac.cs.cmu.edu>
In-Reply-To: <20050520191207.15E3D29528@smtpauth.easystreet.com>
References: <20050520191207.15E3D29528@smtpauth.easystreet.com>
Originator-Info: login-token=Mulberry:01j40sl/n1oQvb2KQYwgtcBib/Y8IWwaX8Alr8xQ0=;
 token_authority=postmaster@andrew.cmu.edu
X-Mailer: Mulberry/3.1.6 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, May 20, 2005 12:12:05 PM -0700 ted creedon 
<tcreedon@easystreet.com> wrote:

> Gcc -dumpmachine  #should prints out i586-suse-linux for a P III here.
>
> I'd try a fresh single processor machine and force a 2.6 kernel, module
> and afs recompile for a i586.
>
> SuSE 9.3 costs $90 and it solved a similar problem noted in the mailings.
> In fact the YasT installed openafs binaries ran fine.
>
> The ksymoops man page has a script to tail -f /var/log/messages|ksymoops1
> explained.
>
> Are you sure there isn't a memory problem? I'm running out of ideas.
> tedc

You're really trying too hard.  The oops in question clearly shows EIP in 
osi_Panic(), which is _supposed_ to result in a crash.  So, stop trying to 
analyze the mechanism by which osi_Panic forces a fault, and instead go 
look at your logs and tell us what the panic string was.
