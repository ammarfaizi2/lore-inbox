Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRKZQfU>; Mon, 26 Nov 2001 11:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281914AbRKZQfK>; Mon, 26 Nov 2001 11:35:10 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:11516 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281915AbRKZQex>;
	Mon, 26 Nov 2001 11:34:53 -0500
Date: Mon, 26 Nov 2001 09:34:14 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Martin Dalecki <dalecki@evision.ag>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.0 kill  read_ahead array.
Message-ID: <20011126093414.B730@lynx.no>
Mail-Followup-To: Martin Dalecki <dalecki@evision.ag>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111221046170.1479-100000@penguin.transmeta.com> <3C022CEF.BC4340A1@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C022CEF.BC4340A1@evision-ventures.com>; from dalecki@evision-ventures.com on Mon, Nov 26, 2001 at 12:52:15PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2001  12:52 +0100, Martin Dalecki wrote:
> This is removing the "write only" read_ahead sparse array from all
> the places where it's "used" by now. 
> This is just saving some memmory.

Is this a case of the "read_ahead" array is redundant and read ahead is
done at a different level (not using this array), or is it a case of
read ahead not being done at all?  If it is not being done at all, then
removing the unused array is the wrong thing to do - we should fix
read ahead, and start using the array.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

