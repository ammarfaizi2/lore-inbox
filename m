Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132725AbRDILl6>; Mon, 9 Apr 2001 07:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132727AbRDILls>; Mon, 9 Apr 2001 07:41:48 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:37125 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S132725AbRDILla>; Mon, 9 Apr 2001 07:41:30 -0400
Date: Mon, 9 Apr 2001 15:05:43 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <20010409150543.A541@jurassic.park.msu.ru>
In-Reply-To: <20010408221123.A22893@jurassic.park.msu.ru> <Pine.GSO.3.96.1010409115004.9470B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010409115004.9470B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 09, 2001 at 12:02:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 12:02:54PM +0200, Maciej W. Rozycki wrote:
>  I think you need an mb here.  To force sychronization with other CPUs.
> Unless you know you are UP or there is no possibility another CPU may
> access the relevant device.

Yes - in most cases you need synchronization at a higher level.
For instance, you don't want other CPUs accessing the device while
you are sending command sequences to it.

Ivan.
