Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbUKMDui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbUKMDui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUKMDtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:49:11 -0500
Received: from siaag1af.compuserve.com ([149.174.40.8]:43153 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S262735AbUKMDsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:48:18 -0500
Date: Fri, 12 Nov 2004 22:45:12 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.10-rc1 (almost solved)
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Message-ID: <200411122248_MC3-1-8E97-BFE5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004 at 17:01:10 -0800 Linus Torvalds <torvalds@osdl.org> wrote:

> > PS: do you have *any* idea how this could be related to the snd-es1371
> > driver (which is producing the oops then)?
>
> I bet it's overwriting some array, and just corrupting memory after it. 
> For example, the edd_info[] array only has 6 entries,

  That's almost certainly the problem.  There can be up to 16 EDD devices
as of the Jun 30 update to the EDD code.

  And sound_class is the next item after edd_info[] in my System.map...


--Chuck Ebbert  12-Nov-04  22:21:27
