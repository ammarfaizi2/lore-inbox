Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSIBGTz>; Mon, 2 Sep 2002 02:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSIBGTz>; Mon, 2 Sep 2002 02:19:55 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:33769 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317393AbSIBGTy>; Mon, 2 Sep 2002 02:19:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 2 Sep 2002 16:23:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15731.1019.581339.120099@notabene.cse.unsw.edu.au>
Cc: Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
In-Reply-To: message from William Lee Irwin III on Sunday September 1
References: <20020902003318.7CB682C092@lists.samba.org>
	<1030945918.939.3143.camel@phantasy>
	<20020902060257.GO888@holomorphy.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 1, wli@holomorphy.com wrote:
> On Mon, 2002-09-02 at 01:23, Rusty Russell wrote:
> >> This week, it spread to SCTP.
> >> "struct list_head" isn't a great name, but having two names for
> >> everything is yet another bar to reading kernel source.
> 
> On Mon, Sep 02, 2002 at 01:51:54AM -0400, Robert Love wrote:
> > I am all for your cleanup here, but two nits:
> > Why not rename list_head while at it?  I would vote for just "struct
> > list" ... the name is long, and I like my lines to fit 80 columns.
> 
> Seconded. Throw the whole frog in the blender, please, not just
> half.

The struct in question is a handle on an element of a list, or the
head of a list, but it is not a list itself.  A list is a number of
stuctures each of which contain (inherit from?)  the particular
structure.  So calling it "struct list" would be wrong, because it
isn't a list, only part of one.

Maybe "struct list_element" or "struct list_entry" would be OK.  But
I'm happy with "struct list_head", because the thing is, at least
sometimes, the head of a list.

NeilBrown
