Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUCRRAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUCRRAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:00:33 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:16325 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262758AbUCRRAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:00:31 -0500
Date: Thu, 18 Mar 2004 16:59:52 +0000
From: Dave Jones <davej@redhat.com>
To: Justin Piszcz <jpiszcz@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
Message-ID: <20040318165952.GA24328@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Justin Piszcz <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
References: <Law10-F95ihL5C2Skqk00028182@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law10-F95ihL5C2Skqk00028182@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 04:40:49PM +0000, Justin Piszcz wrote:

 > My question is, what are the advantages vs disadvantages in updating your 
 > CPU's microcode?

It'll fix known problems in the microcode thats in ROM on your CPU.

 > Is it worth it?

In most cases, yes.  It's zero cost. You don't waste RAM, as the
microcode gets loaded into small RAM areas on the CPU that are
otherwise unused.

 > Does it matter what type of Intel CPU you have?

yes. You need at least a Pentium Pro.
Also Pentium 4 needs a newer format microcode, which isn't available
publically anywhere yet afaik.

 > Do some CPU's benefit more than others for microcode updates?

Some CPUs have more bugs that need fixing than others 8)
Additionally some CPUs may not have a newer microcode available
than the one that it shipped with in ROM

 > Can anyone explain reasons to or not to update the CPU microcode?

In some cases, your BIOS is doing this transparently already.
I've seen instances where moving a CPU between two motherboards
has meant that microcode_ctl has done an upgrade on one, and
done nothing on the other as its already up to date.

If you're already up-to-date, theres no reason to run it.

		Dave

