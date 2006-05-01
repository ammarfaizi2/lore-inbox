Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWEAUKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWEAUKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWEAUKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:10:30 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:62749 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932216AbWEAUK3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:10:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=annGBOZ9hJ12/TcFmWZFgZKnCZZ7MEL+XbZnH9eOCpeJB/ze5baeNxqt5UjOFk4HicULJG6QaTHKufxVpH9kQc5cB4Bc1bzK+BLpAm3AFaKrFKwiEqMW/3pqSRgle7P6noh0GEXSgo4qdFDZ6791wfc8GHkIzft1m+oqwdnNuxc=
Message-ID: <64b292120605011310n59ac3bdew2508bfa8b923adb3@mail.gmail.com>
Date: Mon, 1 May 2006 15:10:27 -0500
From: "Circuitsoft Development" <circuitsoft.devel@gmail.com>
Subject: Fwd: Extended Volume Manager API
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <64b292120605010759h4d9c74d7s717d125018ab95d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com>
	 <200605010702.k4172Q5H006348@turing-police.cc.vt.edu>
	 <64b292120605010759h4d9c74d7s717d125018ab95d3@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Mon, 01 May 2006 00:26:05 CDT, Circuitsoft Development said:
> > about 600 microseconds, topped at 3msec over 10 minutes) I figure that
> > 5msec timeout won't add any noticeable lag to the volume manager, as
> > most disk seek times are in that range.
>
> Note that if you're setting 5ms as your timeout for detecting a *crash*,
> and your *ping* takes 3ms, that leaves you a whole whopping 2ms.  If you
> have 1ms scheduler latency at *each* end (remember - you're in userspace

Volume/Lock manager in Kernelspace - Don't feel like dealing with
user-mode block devices

I was actually planning on a 5msec timeout to ignore that computer,
for now, then if I don't get a response within 100msec,  ping them,
and permenantly remove them from the list of peers and broadcast a
"this peer is dead" message to the network if the ping times out at
500msec.

> at both ends, right?) you have approximately 0ms left for the remote end to
> actually *do* anything, and for the local end to process the reply.
>
> And if the remote end has to issue a syscall during processing the request,
> you're basically screwed.

The code on the remote end is checking a list of locks to see if a
block is in it.
