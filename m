Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWDYHuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWDYHuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWDYHuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:50:07 -0400
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:5511 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751403AbWDYHuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:50:05 -0400
Date: Tue, 25 Apr 2006 03:50:00 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
In-Reply-To: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0604250254520.15998@d.namei>
References: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, Casey Schaufler wrote:

> > Seems like a strawman.  We aren't claiming that SELinux is perfect, 
> > and there is plenty of work ongoing on SELinux usability.  But a 
> > fundamentally unsound mechanism is more dangerous than one that is 
> > never enabled; at least in the latter case, one knows where one 
> > stands.  It is the illusory sense of security that accompanies 
> > path-based access control that is dangerous.
> 
> I suggest that this logic be applied to the "strict policy", "targeted 
> policy", and "user written policy" presentations of SELinux. You never 
> know what the policy might be.

You are conflating the policies provided with SELinux systems with the 
mechanisms of SELinux.

One of the important features of SELinux is its policy flexibility, with 
clean separation of policy and mechanism.  SELinux provides the mechanisms 
to control all security relevant access of processes to data, and accesses 
between processes.

It is up to the policy to determine how much of that mechanism is 
utilized, according to desired security goals.

Targeted policy in fact does perform a usability-security tradeoff (as all 
real security systems must do), aimed at the relatively simple case of 
protecting systems with a few internet facing services.  This is the 
default policy shipped with _millions_ of Fedora and RHEL systems, and 
represent, to the best of my knowledge, the first ever releases of general 
purpose operating systems with MAC enabled by default.

The aims and limitations of targeted policy are very well documented.

If you wished, you could load a simpler policy which can offer an 
equivalent level of protection offered by non-MAC schemes such as 
AppArmor.  In fact, some work has been going on more generally in this 
area in Japan during the last couple of years.

Other types of users will want stricter policies, to meet their security 
goals.  The SELinux mechanism is general enough to cater to very high 
levels of protection and assurance.

So, please, consider that the mechanism of SELinux is quite separate from 
the types of policies which may be deployed.

And that arguments regarding SELinux "complexity" often confuse these 
issues, as well as issues around tools and abstractions presented to 
users.

To make a rough analogy (as Ted mentioned his IETF work earlier...): 

Network security is a complicated issue, the fundamental nature of which 
is determined by the protocols, systems and interactions between them.  
IPsec seeks to provide a robust scheme for protecting a specific set of 
protocols within a specific range of security goals.  If you want to read 
all of the specifications, you'll find it's very complex (too complex, 
according to some).  Yet, after many years of hard work, it's in 
widespread use by general users, most of who simply click on a button on 
their desktop to make it work.  You wouldn't expect end users to actually 
configure IPsec at the lowest levels, and even sysadmins need the right 
tools and abstractions to effectively and safely deploy the technology 
(see how far an average sysadmin gets with racoon and its man page).

The fundamental mechanisms of IPsec are sound.  It has taken many, many 
years to get it to this stage, despite claims of it being "too 
complicated".  In that time, several "simple" protocols were designed and 
implemented to address the "complexity" issues, but it turns out, after 
all, that with the right level of abstraction and tools, IPsec is not too 
complicated to be secure or to use: by the obvious example of both its 
widespread adoption and, afaik, no systemic security failures.

Similarly:

The Linux kernel has a specific level of complexity determined by the 
nature of its many and varied mechanisms for resource access and 
communications.  SELinux seeks to reveal these and provide a mechanism to 
control all security relevant interactions, as required.  Much work is 
underway on implementing and improving tools, and ensuring that the 
abstraction levels are optimal for different classes of users (e.g. end 
users, developers, sysadmins and security architects). I believe it will 
not be long until the new SELinux tools provide a much better experience 
for users, while the underlying security mechanisms will remain sound and 
capable of meeting a very wide range of security objectives.



- James
-- 
James Morris
<jmorris@namei.org>
