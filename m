Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSGYBih>; Wed, 24 Jul 2002 21:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSGYBih>; Wed, 24 Jul 2002 21:38:37 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:16791 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318292AbSGYBig>; Wed, 24 Jul 2002 21:38:36 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Date: Thu, 25 Jul 2002 11:41:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15679.22369.585715.691596@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - mark 2: type safe(r) list_entry repacement: con
In-Reply-To: message from Petr Vandrovec on Wednesday July 24
References: <86E5A7A57@vcnet.vc.cvut.cz>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday July 24, VANDROVE@vc.cvut.cz wrote:
> On 24 Jul 02 at 22:38, Neil Brown wrote:
> > 
> > With the "typeof" suggestion from Kevin, I could just change
> > list_entry and not woory about the fact that lots of people use
> > "list_entry" for things that aren't lists.... but I didn't.
> 
> Hello,
>   is list_entry name really that bad? We have well established 
> list_entry name since at least 2.2.0, and having two same functions 
> with two different names will (IMHO) cause more damage than benefit 
> from "clearer" name is.

Well... "list_entry" is fine when you are working with a list... but
when you aren't it is downright confusing.

The two functions (actually macros) have the same body, but have
conceptually different uses.  Having extra clues in the code to help
readers know what is happening is a *good*thing*.

>                                         Thanks,
>                                             Petr Vandrovec
>                                             
> P.S.: I converted whole matroxfb to use
> list_entry(xxx, struct matrox_fb_info, fbcon) instead of
> (struct matrox_fb_info*)xxx so that I can move fbcon field from 
> first position in matrox_fb_info - so I'm personally interested
> in backward source compatibility.

In the final patch backward source compatability was not broken, so
you should be fine.

NeilBrown
