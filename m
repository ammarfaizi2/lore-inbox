Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287215AbSAHOuu>; Tue, 8 Jan 2002 09:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288076AbSAHOuk>; Tue, 8 Jan 2002 09:50:40 -0500
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:10759 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S287215AbSAHOu0>;
	Tue, 8 Jan 2002 09:50:26 -0500
Message-ID: <T5852fcda58ac1785e72b4@pcow029o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: Rik van Riel <riel@conectiva.com.br>, <linux-mm@kvack.org>
Subject: Re: [PATCH *] rmap based VM  #11a
Date: Tue, 8 Jan 2002 14:50:24 +0000
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0201081045030.872-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0201081045030.872-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 January 2002 12:45 pm, Rik van Riel wrote:
> The first maintenance release of the 11th version of the reverse
> mapping based VM is now available. It fixes agpgart_be and the
> OOM killer. Tests on diskless machines are especially appreciated.
>
> This is an attempt at making a more robust and flexible VM
> subsystem, while cleaning up a lot of code at the same time.
> The patch is available from:
>
>            http://surriel.com/patches/2.4/2.4.17-rmap-11a
> and        http://linuxvm.bkbits.net/
>
>
> My big TODO items for a next release are:
>   - fix page_launder() so it doesn't submit the whole
>     inactive_dirty list for writeout in one go

Hmm - is this necessarily a bad thing? For local disks, if you tell the 
elevator to give these writes minimal priority (i.e. avoid/minimise impact on 
other disk usage), writing out nice big chunks sounds like a good thing...


James.
