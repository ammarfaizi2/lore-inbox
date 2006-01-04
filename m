Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWADJPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWADJPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWADJPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:15:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1981 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751630AbWADJPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:15:49 -0500
Date: Wed, 4 Jan 2006 10:15:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: Jan Blunck <jblunck@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Eliminate __attribute__ ((packed)) warnings for
 gcc-4.1
In-Reply-To: <20060104022530.GA29784@redhat.com>
Message-ID: <Pine.LNX.4.61.0601041014570.29257@yvahk01.tjqt.qr>
References: <20060103113045.GB24131@hasse.suse.de> <20060104022530.GA29784@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	__u8 rate		;
> > +	__u8 width		;
> > +	__u8 length		;
> > +	__u8 compression	;
> > +	__u8 ecm		;
> > +	__u8 binary		;
> > +	__u8 scantime		;
> > +	__u8 id[FAXIDLEN]	;
>
>What's with the funky placement of ; ?
>The rest of the struct looks sensible.
>
Looks like a simple s/__attribute__((packed))// rather than
s/\s+__attribute__((packed))/;
