Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSEUStj>; Tue, 21 May 2002 14:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSEUSti>; Tue, 21 May 2002 14:49:38 -0400
Received: from cata.monarch.net ([24.244.0.11]:57607 "HELO cata.monarch.net")
	by vger.kernel.org with SMTP id <S315430AbSEUSth>;
	Tue, 21 May 2002 14:49:37 -0400
Date: Tue, 21 May 2002 12:44:59 -0600
From: "Peter J. Braam" <braam@clusterfs.com>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.X: intermezzo compile errors
Message-ID: <20020521124459.N24085@lustre.cfs>
In-Reply-To: <m17AApp-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Clearly we need to do something about this.  Apologies for the
problems. 

- Peter -


On Tue, May 21, 2002 at 09:41:57AM -0500, Bob_Tracy wrote:
> Are people actually using the intermezzo fs with recent 2.5.X kernels?
> The compile has been broken for quite some time due to the following:
> 
> (1) linux/include/linux/intermezzo_psdev.h: ISLENTO() define references
>     a "p_pptr" structure member that has been replaced by "parent".
> 
> (2) In the 2.5.5 timeframe, the "i_zombie" member of "struct inode"
>     went away, and most of the filesystem code was modified accordingly.
>     The intermezzo fs never got "the treatment" as far as I can tell.
>     Affected source files are linux/fs/intermezzo/vfs.c and dir.c.
> 
> (3) linux/fs/intermezzo/super.c: no "read_super" structure member.
> 
> (4) linux/fs/intermezzo/psdev.c: syntax error (missing brace) causes
>     numerous compilation errors.  After adding the missing brace,
>     there's still a problem with the third arg of lento_mknod() at
>     line 773.
> 
> If there's an intermezzo patch set somewhere, I'm sure someone will
> point me to it :-).
> 
> -- 
> -----------------------------------------------------------------------
> Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
> rct@frus.com
> -----------------------------------------------------------------------

-- 
