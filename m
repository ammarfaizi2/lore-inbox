Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSEaQeI>; Fri, 31 May 2002 12:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSEaQeH>; Fri, 31 May 2002 12:34:07 -0400
Received: from mark.mielke.cc ([216.209.85.42]:19207 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316182AbSEaQeG>;
	Fri, 31 May 2002 12:34:06 -0400
Date: Fri, 31 May 2002 12:28:15 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile64()?
Message-ID: <20020531122815.A15156@mark.mielke.cc>
In-Reply-To: <200205311553.g4VFrP300813@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 05:53:23PM +0200, Roy Sigurd Karlsbakk wrote:
> where can i find sendfile64()? It doesn't seem to exist in any library 
> anywhere ...

sys/sendfile.h (2.4.18):

    #ifdef __USE_FILE_OFFSET64
    # error "<sys/sendfile.h> cannot be used with _FILE_OFFSET_BITS=64"
    #endif

The real question, then, isn't where is it, but why isn't it?

Somebody else will have to answer this... sorry...
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

