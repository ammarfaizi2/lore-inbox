Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbSKLXhS>; Tue, 12 Nov 2002 18:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSKLXhR>; Tue, 12 Nov 2002 18:37:17 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38988 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267043AbSKLXhP>; Tue, 12 Nov 2002 18:37:15 -0500
Date: Tue, 12 Nov 2002 18:43:49 -0500
From: Doug Ledford <dledford@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Brian C. Huffman" <sheep@graze.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio
Message-ID: <20021112184349.A11757@redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brian C. Huffman" <sheep@graze.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net> <1037144284.10029.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037144284.10029.0.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 12, 2002 at 11:38:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 11:38:04PM +0000, Alan Cox wrote:
> On Tue, 2002-11-12 at 23:06, Brian C. Huffman wrote:
> > Alan / All,
> > 
> > 	I assume this is the patch that's been in your -ac kernels for a 
> > while?  I have an Intel 845GBV board which uses the ICH4 architecture.  
> > I'm happy to report that this patch does allow me to use the integrated 
> > sound on this motherboard, but one thing that I've noticed is that it 
> > seems as though to adjust volume you need to adjust the actual channel 
> > (PCM, CD, etc), rather than main volume.  Any ideas why this might be so?
> 
> It could be the mixer on your board doesnt support main volume control.
> The i8xx audio is half of a whole, it deals with transferring streams of
> audio data and mixer requests down an AC'97 audio bus to a codec which
> does the D/A parts. That codec varies by board.

And in some implementations the codec control labelled PCM2 is actually 
main volume, and I've seen one where a headphone was the actual main 
volume.  So, the answer is tinker with all the available volume sliders to 
see if you can find one that actually changes the volume of everything at 
once, and if you do find it, use it.

On a side note, Alan, this patch looked to be missing the record causes us 
to loose the playback channel patch that you should have.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
