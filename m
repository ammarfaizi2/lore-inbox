Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264959AbUFLXkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbUFLXkq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 19:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUFLXkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 19:40:46 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:43488 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S264959AbUFLXkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 19:40:45 -0400
In-Reply-To: <20040612155123.W21045@build.pdx.osdl.net>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <20040611201523.X22989@build.pdx.osdl.net> <C636D44C-BC2B-11D8-888F-000393ACC76E@mac.com> <20040612135302.Y22989@build.pdx.osdl.net> <ADFD1FB4-BCB5-11D8-888F-000393ACC76E@mac.com> <20040612144437.V21045@build.pdx.osdl.net> <A63B46CC-BCBB-11D8-888F-000393ACC76E@mac.com> <20040612155123.W21045@build.pdx.osdl.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EC1748B2-BCC9-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 19:40:44 -0400
To: Chris Wright <chrisw@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 12, 2004, at 18:51, Chris Wright wrote:
> I don't have a good feel for the PAG data structure, perhaps the
> above would turn out as overkill.  The security api is commented in
> include/linux/security.h, take a gander there.  The blobs are specific
> to the security model, and I don't yet see a need to display them to
> userspace for each PAG.

Ok, well perhaps what I actually need are some extra callbacks for
security modules then.  A token-group (I'm changing the term because
PAG is confused with an older patch) needs to have an access spec
indicating who can read/modify the token-group as a whole and who
can read/modify each token within it.  In my emails with Andy
Lutomirski we have thought about the idea of putting the token-groups
in /proc and running all access through that way.  If we do that, then 
it
would be very practical to just use file permissions and POSIX ACLs
to control access, in which case each token-group and token could
just use the same access-control mechanisms that are used for other
files in /proc.  That would likely be the easiest path

>> Ok, thank you very much, that's exactly what I need.  I am somewhat
>> new to kernel development, so finding my way around the structs is
>> somewhat difficult.  Is there a good guide somewhere on the net that
>> you can point me to?
> Hmm, not really.  The source is best.
Ok, well thanks for pointing out linux/security.h anyway.

Thanks very much for your help!

Cheers,
Kyle Moffett

