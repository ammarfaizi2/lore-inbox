Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTEAXQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTEAXP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:15:59 -0400
Received: from [217.144.230.27] ([217.144.230.27]:56283 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id S262771AbTEAXP6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:15:58 -0400
Date: Fri, 2 May 2003 01:32:03 +0200 (CEST)
From: Ketil Froyn <kernel@ketil.froyn.name>
X-X-Sender: ketil@ketil.hb.local
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: =?ISO-8859-1?Q?P=E5l?= Halvorsen <paalh@ifi.uio.no>,
       Mark Mielke <mark@mark.mielke.cc>, bert hubert <ahu@ds9a.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: sendfile
In-Reply-To: <3EB1A029.7080708@nortelnetworks.com>
Message-ID: <Pine.LNX.4.40L0.0305020124050.1874-100000@ketil.hb.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003, Chris Friesen wrote:

> Pål Halvorsen wrote:
>
> > OK, but I understand that my streaming scenario is not the target
> > application for sendfile.
>
> What stops you from using sendfile (with TCP) to each destination
> separately, with the client only reading from the pipe as needed
> (presumably with a number of frames worth of buffer on the client
> side)?

I don't think TCP is suitable for streaming multimedia stuff to clients.
For instance, if a packet does not arrive on the client, it's better to
handle this in the client and skip a frame or show one of worse quality
than to have the video stop while waiting for the server to resend.

Ketil


