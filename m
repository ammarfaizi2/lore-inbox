Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136515AbRECJxt>; Thu, 3 May 2001 05:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136601AbRECJx3>; Thu, 3 May 2001 05:53:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58117 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136542AbRECJxY>; Thu, 3 May 2001 05:53:24 -0400
Subject: Re: Why recovering from broken configs is too hard
To: esr@thyrsus.com
Date: Thu, 3 May 2001 10:56:07 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503054349.C28728@thyrsus.com> from "Eric S. Raymond" at May 03, 2001 05:43:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vFqD-0005Hb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately....there are a huge bunch of implicit constraints
> created by dependency relationships in the menu tree.  For example,
> all SCSI cards are dependents of the SCSI symbol.  Set SCSI to N
> and all the card symbols get turned off; set any card symbol to Y or M
> and the value of SCSI goes to Y or M correspondingly.

For any given option you have a tree of options that tell you what to change.
This means you can allow the user to set any conflicting variable either
way and ripple the changes into the tree then start again

For real world cases that will terminate pretty fast. 

Alan

