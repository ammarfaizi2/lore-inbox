Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130633AbRAHSwu>; Mon, 8 Jan 2001 13:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130894AbRAHSwk>; Mon, 8 Jan 2001 13:52:40 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:63478 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S130633AbRAHSw1>;
	Mon, 8 Jan 2001 13:52:27 -0500
Date: Mon, 8 Jan 2001 19:51:40 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108195140.A2051@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108192455.A1891@stefan.sime.com> <Pine.GSO.4.21.0101081332460.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101081332460.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 01:33:50PM -0500
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:33:50PM -0500, Alexander Viro wrote:
> 
> On Mon, 8 Jan 2001, Stefan Traby wrote:
> 
> > On Mon, Jan 08, 2001 at 01:22:49PM -0500, Alexander Viro wrote:
> > 
> > > Here's another one: suppose that /foo is a mountpoint and you have
> > > no read permissions on it. Try to open the thing...
> > 
> > I would return EACCESS.
> > [EACCES]
> >           Search permission is denied for a component of the path prefix.
> 
> And prefix would be what? "/"? Besides, I said that you don't have
> read permissions on /foo, not search ones.

And what ?

--------------------------------------------------
changing errno. If the implementation needs to use path to
determine the value of name and the implementation does not support
the association of name with the file specified by path, or if the
process did not have appropriate privileges to query the file
specified by path, or path does not exist, pathconf() returns -1
and errno is set to indicate the error.
--------------------------------------------------
                                
So this is case is covered.

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
