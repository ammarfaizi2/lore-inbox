Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRKTLom>; Tue, 20 Nov 2001 06:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281029AbRKTLoc>; Tue, 20 Nov 2001 06:44:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47372 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281027AbRKTLoR>; Tue, 20 Nov 2001 06:44:17 -0500
Date: Tue, 20 Nov 2001 09:43:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <E1661fQ-0001UQ-00@localhost>
Message-ID: <Pine.LNX.4.33L.0111200943050.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Ryan Cumming wrote:
> On November 19, 2001 18:49, Eric W. Biederman wrote:
> > That would probably do it.  Though it is puzzling why after the file
> > is munmaped it's pages aren't recycled.
>
> Because they're part of the page cache now, and won't be recycled
> until newer pages 'push' them out of memory.

Newer pages cannot push them out of memory, due to use-once.
That is, unless those newer pages also get mmap()d or if they
get accessed really often.

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

