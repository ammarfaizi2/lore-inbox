Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278940AbRKIA4D>; Thu, 8 Nov 2001 19:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278943AbRKIAzx>; Thu, 8 Nov 2001 19:55:53 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63419 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278940AbRKIAzj>; Thu, 8 Nov 2001 19:55:39 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "D'Angelo Salvatore" <dangelo.sasaman@tiscalinet.it>
Date: Fri, 9 Nov 2001 11:55:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15339.10605.798015.895306@notabene.cse.unsw.edu.au>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux <linux-kernel@vger.kernel.org>
Subject: Re: nfsd
In-Reply-To: message from D'Angelo Salvatore on Thursday November 8
In-Reply-To: <3BE96ED9.6030307@tiscalinet.it>
	<01110716095400.00823@nemo>
	<3BEAD6FE.6080307@tiscalinet.it>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 8, dangelo.sasaman@tiscalinet.it wrote:
> 
> Hi,
> 
> The problem still be present, but the message is a little bit different:
> 
> nfsd.o: unresolved symbol nfsd_linkage_Rb56858ea
> 
> I hope that this information can help you to find the problem in the
> kernel build process.

My guess would be that you built the kernel without any support for
nfsd, even as a module.  And then tried to build nfsd as a module
afterwards.
Unfortunately this doesn't work.

I suggest that you rebuild the kernel again with CONFIG_NFSD set to M,
and the build the modules.  I'm sure they will link then.

NeilBrown
