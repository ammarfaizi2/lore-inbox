Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283932AbRLEKR5>; Wed, 5 Dec 2001 05:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283942AbRLEKRr>; Wed, 5 Dec 2001 05:17:47 -0500
Received: from ASYNC8-CS2.NET.CS.CMU.EDU ([128.2.188.152]:15634 "EHLO
	mentor.odyssey.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S283932AbRLEKRd>; Wed, 5 Dec 2001 05:17:33 -0500
Date: Wed, 5 Dec 2001 05:17:34 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>, Cameron Simpson <cs@zip.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: CML2 with python1
Message-ID: <20011205051734.A22345@cs.cmu.edu>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Cameron Simpson <cs@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <20011204120305.A16578@thyrsus.com> <E16BJcB-0002o7-00@the-village.bc.nu> <20011205125938.A21170@zapff.research.canon.com.au> <20011205032954.B4836@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011205032954.B4836@thyrsus.com>
User-Agent: Mutt/1.3.23i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 03:29:54AM -0500, Eric S. Raymond wrote:
> Cameron Simpson <cs@zip.com.au>:
> > ESR, is it practical to have CML2 transcribe a CML1 config file?
> 
> No, alas.

But it _is_ entirely practical to run CML2 with a bog-standard python
1.5 interpreter. I just did a search/replace for the python2-ism's like

 <x> += <y>           =>  <x> = <x> + <y>, and
 <string>.<op>(<arg>) => string.<op>(<string>, <arg>)

Worked around some missing functionality in the older shlex and curses
modules and I can now use oldconfig, menuconfig, xconfig, and cmladvent
with CML2 and a python1 interpreter. It also still works fine with
python2 as well.

	http://ravel.coda.cs.cmu.edu/cml2-1.9.4-python1.patch (36K)

36K might sound like a lot, but given the fact that the CML python
sources totals about 280KB, it is a pretty small diff, and the whole
"but python2 isn't standard in distributions and the license is bad"
argument can be dropped and we can get on with life.

Jan

