Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVBBMrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVBBMrd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 07:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVBBMrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 07:47:33 -0500
Received: from main.gmane.org ([80.91.229.2]:2779 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262533AbVBBMr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 07:47:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Wed, 2 Feb 2005 12:46:27 +0000 (UTC)
Message-ID: <loom.20050202T134427-571@post.gmane.org>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>  <pan.2005.02.01.20.21.46.334334@surrey.ac.uk> <1107299901.5624.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 20.133.0.12 (Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.5) Gecko/20041107 Firefox/1.0)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh <at> kernel.crashing.org> writes:
> This looks like bogus HW, or bogus list of IDE interfaces ...

How can I test to see if this is the case?

> 
> The IDE layer waits up to 30 seconds for a device to drop it's busy bit,
> which is necessary for some drives that aren't fully initialized yet.

Sure, make sense.

> I suspect in your case, it's reading "ff", which indicates either that
> there is no hardware where the kernel tries to probe, or that there is
> bogus IDE interfaces which don't properly have the D7 line pulled low so
> that BUSY appears not set in absence of a drive.

Right. How do I find the value of D7?

> I'm not sure how the list of intefaces is probed on this machine, that's
> probably where the problem is.

Thanks, Richard Hughes




