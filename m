Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279969AbRKJRwF>; Sat, 10 Nov 2001 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRKJRvp>; Sat, 10 Nov 2001 12:51:45 -0500
Received: from codepoet.org ([166.70.14.212]:47412 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280394AbRKJRvk>;
	Sat, 10 Nov 2001 12:51:40 -0500
Date: Sat, 10 Nov 2001 10:51:38 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Davidovac Zoran <zdavid@unicef.org.yu>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Matthias Schniedermeyer'" <ms@citd.de>,
        Rik van Riel <riel@conectiva.com.br>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
Message-ID: <20011110105138.A11060@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Davidovac Zoran <zdavid@unicef.org.yu>,
	Torrey Hoffman <torrey.hoffman@myrio.com>,
	'Matthias Schniedermeyer' <ms@citd.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CABE@mail0.myrio.com> <Pine.LNX.4.33.0111101746020.11836-100000@unicef.org.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111101746020.11836-100000@unicef.org.yu>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 10, 2001 at 05:47:15PM +0100, Davidovac Zoran wrote:
> try
> hdparm -d1 /dev/hda
> hdparm -d1 /dev/hdb
> and test them now

Sure.  But that isn't the point.  The point is that even if the
drive is capable and the chipset is capable, there still seem to
be corner cases where DMA is not enabled.

In my case, the chipset and drives in my box are both known to
work with DMA enabled and the ide chipset is even in the IDEDMA
white list.  But DMA is still not being enabled by default, so
there is a bug somewhere,

So why don't I want to hard code hdparm in an init script?  Lets
suppose for a moment there are programs that need to run on all
sorts of strange hardware and which depend on trying to run the
hard drives as fast as possible.  For example, think of the
installer for your favorite distro.  Redhat or Debian or whatever
couldn't very well put 'hdparm -d1 /dev/hda' in the init scipts
since for all they know there might be a cmd640 under the hood...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
