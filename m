Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSJWIak>; Wed, 23 Oct 2002 04:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJWIak>; Wed, 23 Oct 2002 04:30:40 -0400
Received: from relay.muni.cz ([147.251.4.35]:1667 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S262911AbSJWIaj>;
	Wed, 23 Oct 2002 04:30:39 -0400
Date: Wed, 23 Oct 2002 10:36:16 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021023103616.B20511@fi.muni.cz>
References: <20021022184034.GA26585@win.tue.nl> <Pine.LNX.4.44L.0210221609260.7060-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0210221609260.7060-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Oct 22, 2002 at 04:10:02PM -0200
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
: 
: 
: On Tue, 22 Oct 2002, Andries Brouwer wrote:
: 
: > On Tue, Oct 22, 2002 at 04:19:57PM +0200, Jan Kasprzak wrote:
: >
: > > 	I.e. if you read the /proc/partitions in single read() call,
: > > it gets read OK. However, if you read() with smaller-sized blocks,
: > > you get the truncated contents.
: >
: > Having statistics in /proc/partitions leads to such problems.
: > Make sure you do not ask for them.

	Yes I have CONFIG_BLK_STATS (and I need this to know
when my server gets overloaded).
: 
: Its not forced behaviour. Its a config option and its defaulted to off.
: 
: Some people want it.

	Yes.

	Maybe it should be documented that you have to read it
in a single read() syscall with big enough buffer.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
