Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143720AbRAHNSu>; Mon, 8 Jan 2001 08:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143736AbRAHNSk>; Mon, 8 Jan 2001 08:18:40 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:33779 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S143720AbRAHNS1>;
	Mon, 8 Jan 2001 08:18:27 -0500
Date: Mon, 8 Jan 2001 14:17:21 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108141721.C13072@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <Pine.GSO.4.21.0101080711470.4061-100000@weyl.math.psu.edu> <E14FbNU-0004SI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14FbNU-0004SI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 08, 2001 at 12:26:17PM +0000
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 12:26:17PM +0000, Alan Cox wrote:

> I can put all that in the VFS so I did (right now the ext2 size calculator is
> wrong but thats proof of concept detail). Just need to shift if over from
> ext2/file.c

Try 'getconf LINK_MAX /ramfs'.
While the result (127) is in some way SuS/POSIXLY_CORRECT,
it's not the truth.

Why not start to fix this problem outside the funny switch/case in glibc ?
The filesystem itself should able to handle this.

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
