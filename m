Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVIKCRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVIKCRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 22:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVIKCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 22:17:12 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:35673 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932424AbVIKCRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 22:17:10 -0400
Subject: Re: V4L: Experimental Sliced VBI API support
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
In-Reply-To: <20050910184419.53267837.akpm@osdl.org>
References: <1126401293.6807.33.camel@localhost>
	 <20050910184419.53267837.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 10 Sep 2005 23:17:11 -0300
Message-Id: <1126405031.6807.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-8mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sáb, 2005-09-10 às 18:44 -0700, Andrew Morton escreveu:
> Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
> >
> > - adds all defines, ioctls and structs needed for the sliced VBI API
> >
> 
> What is "sliced VBI"?
	Sorry for this... it is too much video jargon :-)
	VBI = Vertical Blank Interval.
	It is related with the way TV signals does work. It sends a line, then,
it has a retrace time to allow the tube to move electrons to the
beginning of the next line. This was the main reason at the beginning of
analog B&W TV.
	There are a lot of bandwidth lost on VBI. So, lots of TV systems uses
it to send other informations, like Closed Capture and Teletext. Also,
broadcasters uses this as a channel to exchange information from the
content producer to their subsidiaries at each city.
	There's already a raw VBI interface on V4L2 api, used for Closed
Captions and Teletext. The decoding is doing at userlevel space and it
is mostly for analog TV signals, non encoded.
	Encoded signals (MPEG, for example), may need also to transmit other
informations (like, for example, display aspect, i.e. 4x3,
widescreen...). Sliced VBI interface is a method to allow the video
stream to transmit this kind of information.
> 
Cheers, 
Mauro.


