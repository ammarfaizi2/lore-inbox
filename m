Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319197AbSIDPqY>; Wed, 4 Sep 2002 11:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319194AbSIDPqV>; Wed, 4 Sep 2002 11:46:21 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:17650 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319191AbSIDPpL>; Wed, 4 Sep 2002 11:45:11 -0400
Date: Wed, 4 Sep 2002 11:49:45 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Joseph N. Hall" <joseph@5sigma.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE-DVD problems [excuse former idiotic topic]
Message-ID: <20020904114945.C1394@redhat.com>
References: <200209041530.g84FUM124938@mx1.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209041530.g84FUM124938@mx1.redhat.com>; from joseph@5sigma.com on Wed, Sep 04, 2002 at 08:48:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 08:48:00AM -0700, Joseph N. Hall wrote:
> * Performance is terrible
> * booting with noapic makes no difference
> * Performance seems to indicate some kind of difficulties in
>   the kernel, perhaps connected to interrupt handling

That's what happens when DMA isn't being used: the kernel spends lots of 
time copying data from the drive in the interrupt handler and not allowing 
userspace to execute.

		-ben
