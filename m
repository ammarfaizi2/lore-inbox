Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293448AbSC3Xss>; Sat, 30 Mar 2002 18:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293541AbSC3Xsi>; Sat, 30 Mar 2002 18:48:38 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:7907 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S293448AbSC3Xsc>; Sat, 30 Mar 2002 18:48:32 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>
Date: Sun, 31 Mar 2002 09:48:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15526.20182.949443.871413@notabene.cse.unsw.edu.au>
Cc: Timothy Murphy <tim@birdsnest.maths.tcd.ie>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
In-Reply-To: message from Alexander Viro on Saturday March 30
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday March 30, viro@math.psu.edu wrote:
> 
> 
> On Sat, 30 Mar 2002, Timothy Murphy wrote:
> 
> > I'm sure this has been recognised,
> > but I would point out that sys_nfsservctl is not "undefined"
> > if NFSD is not chosen.
> > 
> > The following patch to .../arch/i386/kernel/entry.S corrects this,
> > though this is obviously not the right place to put it:
> 
> Wrong fix.  Using weak aliases would do it in cleaner way, but there's
> a sparc64 toolchain bugs that don't allow that.

I cannot see the weak aliases being a real fix either.
If you compile with NFSD as a module, and with CONFIG_KMOD, then the
nfssvc_ctl systemcall is suppose to auto-load nfsd.o.  How can this be
achieved with weak aliases?

NeilBrown
