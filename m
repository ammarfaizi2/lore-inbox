Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTKZCaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbTKZCai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:30:38 -0500
Received: from rth.ninka.net ([216.101.162.244]:22148 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263923AbTKZCah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:30:37 -0500
Date: Tue, 25 Nov 2003 18:30:35 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Mr. BOFH" <icerbofh@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031125183035.1c17185a.davem@redhat.com>
In-Reply-To: <BAY1-DAV15JU71pROHD000040e2@hotmail.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 16:15:12 -0800
"Mr. BOFH" <icerbofh@hotmail.com> wrote:

> http://www.theregister.co.uk/content/61/33440.html

This was amusing to read, let's read the claim carefuly,
shall we?

	"We worked hard on efficiency, and we now measure,
	 at a given network workload on identical x86 hardware,
	 we use 30 percent less CPU than Linux."

So his claim is that, in their mesaurements, "CPU utilization"
was lower in their stack.  Was he using 2.6.x and TSO capable
cards on the Linux side?  If not, it's not apples to apples
against are current upcoming technology.

And while his CPU utilization claim is interesting (I bet that gain
would go to zero if they'd used Linux TSO in 2.6.x), but was the
networking bandwidth and latency any better as a result?  I think it's
not by accident that the claim was phrased the way it was.

In fact, I bet their connection setup/teardown latency will go in the
toilet with this stuff and Solaris was already horrible in this area.
It is a well established fact that TOE technologies have this problem
because of how the socket setup/teardown operation with TOE cards
requires the OS to go over the bus a few times.

I'm not worried at all about Sun's fire engine.  It's preliminary
technology, and they are going to discover all of the problem TOE
stuff has that I've discussed several times on this list.

They even mention that they don't even support any current generation
shipping TOE cards yet, at least I offer a cpu utilization reduction
optimization (TSO in 2.6.x) with multiple implementation on current
generation hardware (e1000, tg3, etc.).

I fully welcome them to put Linux up against their incredible fire
engine crap in a sanctioned specweb run on identical hardware.  :)
