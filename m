Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSKLXGF>; Tue, 12 Nov 2002 18:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbSKLXGF>; Tue, 12 Nov 2002 18:06:05 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:22184 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267016AbSKLXGE>; Tue, 12 Nov 2002 18:06:04 -0500
Subject: Re: i810 audio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Brian C. Huffman" <sheep@graze.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net>
References: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 23:38:04 +0000
Message-Id: <1037144284.10029.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 23:06, Brian C. Huffman wrote:
> Alan / All,
> 
> 	I assume this is the patch that's been in your -ac kernels for a 
> while?  I have an Intel 845GBV board which uses the ICH4 architecture.  
> I'm happy to report that this patch does allow me to use the integrated 
> sound on this motherboard, but one thing that I've noticed is that it 
> seems as though to adjust volume you need to adjust the actual channel 
> (PCM, CD, etc), rather than main volume.  Any ideas why this might be so?

It could be the mixer on your board doesnt support main volume control.
The i8xx audio is half of a whole, it deals with transferring streams of
audio data and mixer requests down an AC'97 audio bus to a codec which
does the D/A parts. That codec varies by board.

