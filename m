Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293599AbSCPAcB>; Fri, 15 Mar 2002 19:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293600AbSCPAbv>; Fri, 15 Mar 2002 19:31:51 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:48911 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293599AbSCPAbg>; Fri, 15 Mar 2002 19:31:36 -0500
Date: Sat, 16 Mar 2002 01:31:34 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020316013134.A31470@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020315111022.S29887@work.bitmover.com> <Pine.LNX.4.33.0203151110130.29289-100000@penguin.transmeta.com> <20020315113001.W29887@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020315113001.W29887@work.bitmover.com>; from lm@bitmover.com on Fri, Mar 15, 2002 at 11:30:01AM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 11:30:01AM -0800, Larry McVoy wrote:
> 
> If you use vim and ctags, it sucks because I haven't yet taught vim how 
> to go from a read only revision controlled file to a read/write file.  
> It would be way cool if some vim genius out there showed me how to do
> that, I know it is possible, vim has the hooks, I simply don't have the
> time to go figure it out.

I'm certainly not a "vim genius", but somehow I managed to write some
vim autocmds that do this ;-)

You can get the vim script from

    http://www.myipv6.de/vim/extensions/bk.vim

Simply source it from your .vimrc. I tested it with vim 6.0 only,
although it should also work with prior versions.

On open, it tries to checkout a file from bitkeeper if it isn't
already checked out (doing "bk get" if you open it readonly and "bk
edit" otherwise), and it "bk edit"s the file if you start making
changes to a readonly bitkeeper controlled file.

Unfortunately, vim doesn't trigger the FileChangedRO autocmd if you do
a ":set readonly!" to go from readonly to read/write, so it doesn't
handle this case (AFAIK there is no way to intercept this command).

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
