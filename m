Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbTJTJMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 05:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJTJMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 05:12:52 -0400
Received: from main.gmane.org ([80.91.224.249]:30896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262468AbTJTJMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 05:12:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Suspend with 2.6.0-test7-mm1
Date: Mon, 20 Oct 2003 11:12:48 +0200
Message-ID: <yw1xptgsb7cf.fsf@users.sourceforge.net>
References: <3F93A093.9060800@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:+Kbi7U5lGBftNqgE4I5J/F2IV6Q=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> writes:

> I've been playing with the suspend features of 2.6.0-test7-mm1 and I
> can't get it to work. When I do "echo -n standby > /sys/power/state",
> the screen flickers briefly and then the system is back to normal. In
> the logs I see the following message:
> 
> Now, I wonder, what is causing the kernel to exit from the suspend
> immediately? Is it error in suspend code, drivers that doesn't support
> suspend or some program that is interrupting the sleep? How do I debug
> this further?

I've seen this, too.  Try "sleep 1; echo -n standby > /sys/power/state".  
I theory I thought of, is that the system suspends before you have
time to release the enter key, and the key release triggers a wakeup.
Does this seem reasonable to those more knowledgeable?

-- 
Måns Rullgård
mru@users.sf.net

