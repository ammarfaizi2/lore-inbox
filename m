Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbTBJW2s>; Mon, 10 Feb 2003 17:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTBJW2s>; Mon, 10 Feb 2003 17:28:48 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:50391 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id <S265385AbTBJW2h>;
	Mon, 10 Feb 2003 17:28:37 -0500
From: "LA Walsh" <law@tlinx.org>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>, <linux-security-module@wirex.com>
Subject: RE: [BK PATCH] LSM changes for 2.5.59
Date: Mon, 10 Feb 2003 14:38:12 -0800
Message-ID: <004e01c2d155$184a8f00$1403a8c0@sc.tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <200302101957.OAA08418@moss-shockers.ncsc.mil>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Stephen D. Smalley [mailto:sds@epoch.ncsc.mil] 
> Linda Walsh wrote:
> > 	A security model that mediates access to security objects by
> > logging all access and blocking access if logging cannot continue is
> > unsupportable in any straight forward, efficient and/or 
> non-kludgy, ugly way.  
> 
> Could this possibly be a result of the above being a fundamentally
> flawed security model? 
---
	Perhaps you should discuss this with your employer, since it
was the DoD and NSA that came up with the policy.  


> Not to mention it being primarily an auditing
> model rather than a real access control model.  It also seems a bit
> problematic regardless of your kernel security framework; what does
> "logging cannot continue" truly mean? 
---
	For someone working in security, I'm surprised you aren't familiar
with the Controlled Access Protection Profile (CAPP).  It's a superset of
the old DoD "Orange Book" "C2" standard. 
 
	The above policy, which you say isn't a "real access control model"
falls under the "Controlled Access" PP's definition of Access Control.
Are you saying the CAPP isn't "really" an Access Control specification for
an OS?  It is onthe "Common Criteria's" OS list 
(http://www.commoncriteria.org/ccc/protection_profiles/ppinfo.jsp?id=4&status=Certified).  
	Of course if 15-country recognition isn't enough, there's your  employer's own Trusted Product page
(http://www.radium.ncsc.mil/tpep/).  
The CAPP specifies detail used in evaluating whether or not one "truly" 
meets the requirement. Maybe you can find someone around where 
you work who is more familiar with CC security evaluations who can
give you more information.


> Do you have to verify that the
> log record made it to disk before you can proceed with the operation?
---
	I'll refer you to section 5.1 of the above document. It describes 
the required audit policies, one of which, includes the _option_ of 
stopping the machine.

	Is it fundamentally flawed security for a bank to have an ATM shut down if it can no longer log or record transactions?


> <insane ranting about evil conspiracies ignored>
---
	<we don't like what she is saying...quick, call her a witch, a 
heretic, lets portray her as, bwahaha, i-n-s-a-n-e!>  "Evil?"  I don't
recall that word.  I'm fuzzy on the whole good-evil thing.  Whattya mean 'evil?'



> > 	Also unsupported: The "no-security" model -- where all security 
> > is thrown out (to save memory space and cycles) that was 
> desired for embedded 
> work.
> 
> The capabilities logic was moved into a module, and you have 
> the option
> of building a kernel with traditional superuser logic (dummy security
> module) rather than capabilities.
---
	Geez...am I the only one who sees SuperUser and DAC as security
models?  Maybe <eyes grow maniacally wild>, I really am i-n-s-a-n-e...



> An auditing issue, not an access control issue.  
---
	So you are asking us to believe, for example, that bank transaction
logs have nothing to do with bank or account security.  That in no way do
such logs/records provide any sort of control on access?  I disagree.


> As previously
> discussed, there is no channel as long as both checks return the
> same error (and doing otherwise is a compatibility problem).
---
	No channel?  Who's talking about channels?  Did I mention channels?
Nep.  I have my Intrusion Detection system set to go off only on 
mandatory policy violations.  I don't care about penny-ante DAC violations,
they are a dime a dozen, but attempts to override mandatory constraints?
That's suspicious on my machine.  I'd like to know exactly what you 
were trying to do when you attempted to open /usr/sbin for write. 

 

>  Moving all of the DAC logic into a module is _not_ necessary
> to add support for strong access controls.  
---
	Neither is electricity.  Lock the computer in a vault, encase it
in 50 feet of concrete!  *Way* secure.  Oh...you want it to be
'usable'?  Maybe we want to make the system a bit more accessible and
configurable?



> And modularizing that logic
> has interesting implications; what happens to your applications when
> you turn off the kernel DAC logic and replace it with something
> arbitrary?  
---
	You tell me.  The idea is configurability: "truly generic".  It 
depends on what policy you define.  I'm not about to guess
what would happen to "applications" (which?  Random?) that _you_ put on 
your own system that has a security policy that _you_ define.





