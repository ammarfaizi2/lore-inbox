Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWDYQo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWDYQo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWDYQo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:44:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:14832 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751610AbWDYQo2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:44:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYcFaMcPBca+dWG0DfGjto1opzWs0aZGhz0tmvqAeBWyM3XeqY6n2VgUXCaCf/GB37I3fLhpwfETHgUy4m6V6xZ7GBfOfzHoYlHX0lAyrO6PIx62t39ad0emxy7yuxEtpK7A7P+RviopkbeeqRY5i94ZH+rwqLrLSQ+F5pdDxqo=
Message-ID: <9c21eeae0604250944o7234408ct1e8c4c416e7dd5bd@mail.gmail.com>
Date: Tue, 25 Apr 2006 09:44:28 -0700
From: "David Brown" <dmlb2000@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16.2 -> 2.6.16.9 smp apic network problems
In-Reply-To: <9c21eeae0604222322s5155acbeq6136fd6fab0f0da7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0604222322s5155acbeq6136fd6fab0f0da7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is kind of an odd situation and I'm thoroughly confused as to why
things don't work.

I have a router/file server/web server, dual p3 board with two nics
one using the tulip and the other using 8139too driver.

For as long as I can remember I've had to put noapic on the kernel
cmdline to get network to work. Something having to due with local
apic and apic being automatically selected when enabling smp.  With
apic I don't have any network, dhcpcd doesn't work I can assign static
ip's and static routes but can't ping anything no trafic in or out.

I tried removing the noapic lines all together and it won't even
register the network device (ie modprobes just fine but ifconfig -a
doesn't show a new network device).

And now when I upgraded the kernel to 2.6.16.9 from 16.2 I'm getting
the same results as without passing noapic to the kernel. I have no
network connectivity with these later releases of the stable kernel.
Any suggestions as to why this is happening and what I can do to
update my kernel and make things work would be helpful.  I've tried
passing noapic and nolapic but the kernel apparently doesn't recognize
nolapic (documentation fix there).

When I remove smp I have the options to remove apic and local apic and
things work fine with one processor. However I really don't want to be
stuck using one processor on a dual processor system for the rest of
it's days.

I'm still not getting it to work even with 2.6.16.11 has the same
results I already sent this to kernelnewbies but no one responded
really so I'm sending it to lkml.

- David Brown
