Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWEIHY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWEIHY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWEIHY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:24:59 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:33969 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751444AbWEIHY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:24:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hZoVu4yS8j5NiIKu03LLbK6TkQ9SMx//uvVtEpjlC18jVSyc9/F6GoKWP7v8RmR7g0LES4gtjz8xf910aVMXqkF5dJxHtu7gX+ZLQ0f/VlOPyzylbZTvO+eMjxkQmZBNYHH9cbMGq6MmodUy6ekoPB4gDpmdDQXXgWe2PwEJHaA=
Message-ID: <64b292120605090024o389cc482w479981eda50e911b@mail.gmail.com>
Date: Tue, 9 May 2006 02:24:58 -0500
From: "Circuitsoft Development" <circuitsoft.devel@gmail.com>
To: "Lars Marowsky-Bree" <lmb@suse.de>
Subject: Re: Fwd: Fwd: Extended Volume Manager API
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060508215136.GQ5856@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com>
	 <200605010702.k4172Q5H006348@turing-police.cc.vt.edu>
	 <64b292120605010759h4d9c74d7s717d125018ab95d3@mail.gmail.com>
	 <64b292120605011310n59ac3bdew2508bfa8b923adb3@mail.gmail.com>
	 <Pine.LNX.4.64.0605020842250.29285@cuia.boston.redhat.com>
	 <64b292120605062123gdb302d2g201fa59e93bc6a25@mail.gmail.com>
	 <64b292120605081417y1684cba4kfb85ce39c14df0f7@mail.gmail.com>
	 <20060508215136.GQ5856@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/06, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2006-05-08T16:17:07, Circuitsoft Development <circuitsoft.devel@gmail.com> wrote:
>
> > I'm not. They also need to get permission from the network before they
> > write to the disk, and they're not going to get permission without
> > hearing back from everybody. Besides, since the same network is used
> > to connect to the disks as is used to connect the computers to each
> > other, how would it be able to access the disks without being able to
> > access other computers which also connect to the disks?
>
> You really should read up about split-brain scenarios

I don't see how they'll happen if the heartbeat/management runs over
the same network that is used to connect to the disk.

> quorum

I'm aware of the idea. I think that a static quorum would be best, and
that it should be configured by the cluster administrator. See
http://lists.osdl.org/pipermail/osdlcluster/2004-January/000071.html
for a description of the problem with dynamic quorum.

> IO fencing

The primary target storage protocol is ATA-over-Ethernet, second is
iSCSI. As far as I know, it should be relatively simple, in both
circumstances, to tell the storage blade to cut off a computer until
it correctly re-registers itself with the cluster. Otherwise, a CISCO
managed switch should also be able to cut off a computer if it stops
responding to the cluster.

> cluster membership algorithms

Having trouble finding too many details on these. I'll keep looking,
but some pointers could be helpful.

> and the amazing variety of different types of crashes.

I figured that IO Fencing combined with STONITH (Shoot The Other Node
In The Head) could solve the problems caused by most crashes.

>
> Sincerely,
>     Lars Marowsky-Brée
>
> --
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX Products GmbH - A Novell Business     -- Charles Darwin
> "Ignorance more frequently begets confidence than does knowledge"
>

These thoughts are based on my best understanding of how-stuff-works
so far. Any further comments would be greatly appreciated.


- Alex
