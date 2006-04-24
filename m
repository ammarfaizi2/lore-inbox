Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWDXPpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWDXPpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWDXPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:45:31 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:896 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id S1750922AbWDXPpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:45:31 -0400
Date: Mon, 24 Apr 2006 07:45:01 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]  implementation
 of LSM hooks)
In-Reply-To: <20060424140407.GD22703@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.62.0604240730030.30494@qynat.qvtvafvgr.pbz>
References: <4446D378.8050406@novell.com>  <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
  <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> 
 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> 
 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> 
 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> 
 <20060424082424.GH440@marowsky-bree.de>  <1145882551.29648.23.camel@localhost.localdomain>
  <20060424125641.GD9311@sergelap.austin.ibm.com> 
 <1145887333.29648.44.camel@localhost.localdomain> <20060424140407.GD22703@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, Serge E. Hallyn wrote:

> Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
>> Thus this sort of stuff needs to be taken seriously. Can SuSE provide a
>> good reliable policy for AppArmour to people, can Red Hat do the same
>> with SELinux ?
>
> That's a little more than half the question.  The other 40% is can users
> write good policies.
>
> I think it will, and already has, become easier for selinux.  But in
> this case I wonder whether some sort of contest could be beneficial.  We
> all know of Russel Coker's open root selinux play machines.  That's a
> powerful statement.  Things I'd like to see in addition are

One key difference between SELinux and AppArmor is that AA is _not_ 
designed to protect against the actions of root, it's designed to block 
attacks that would let someone become root.

becouse of this strategy it's far simpler to configure becouse you do not 
have to do all the work to control root. This also limits what it can 
defend against, and so it's not 'perfect security' (and after all there is 
only one way to get 'perfect security' 
http://www.ranum.com/security/computer_security/papers/a1-firewall/ ), but 
AA is still a useful tool.

the 'hard shell, soft center' approach isn't as secure as 'full 
hardening' (assuming that both are properly implemented), but the fact 
that it's far easier to understand and configure the hard shell means that 
it's also far more likly to be implemented properly.

remember that it's not really a matter of people deciding not to write 
SELinux policies and instead do AA, it's a matter of people deciding to 
use AA instead of doing nothing.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

