Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273183AbRIJDkr>; Sun, 9 Sep 2001 23:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273184AbRIJDkh>; Sun, 9 Sep 2001 23:40:37 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:36480 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S273183AbRIJDkZ>; Sun, 9 Sep 2001 23:40:25 -0400
Date: Sun, 9 Sep 2001 23:40:39 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Trever L. Adams" <vichu@digitalme.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] LDAP vs NIS+ security
Message-ID: <20010909234039.A4229@alcove.wittsend.com>
Mail-Followup-To: "Trever L. Adams" <vichu@digitalme.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B9C204A.7070801@digitalme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B9C204A.7070801@digitalme.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 10:07:06PM -0400, Trever L. Adams wrote:
> I am sorry to write this off topic message.  I should probably go look 
> in google for the answer... however -

> Someone in arguing about implimenting directory services into the kernel 
> said that NIS+ will always be more secure than LDAP over SSL... why is this?

	FIIK...  /;-(

	NIS (FKA Sun Yellow Pages) was so insecure it became know as
the "Network Intruder Service".  NIS+ was suppose to address most of
the NIS security issues and it did to a large extent, but created
more than a few problems along the way (having had to managed a mixed
Sun OS 4.x and Solaris 2.x environment, I have more than my share of
horror stories).

	AFAIK, there is no NIS+ server on Linux.  The home page for the
NIS+ utils states it quite plain that there is no Linux server and there
appears to be no prospect of there EVER being and NIS+ server on Linux
(reasons are unstated there, but I have heard comments about closed
protocols and proprietary information and refusals to release critical
information).

	Also, AFAIK, while NIS could support nice things like MD5 password
hashes, NIS+ can not.  Now, I haven't verified this personally, but that
would seem to be a highly UNACCEPTABLE step backwards if NIS+ can not
support higher grade password hashes and long pass phrases!

	Sooo...  Why in bloody hell would we want to lock ourselves into
a proprietary system which would force use to depend on servers based on
other systems and force us to use decidedly inferior authentication
standards?  That certainly doesn't sound "more secure" to me.

	Then too, what grade cryptography is NIS+ using?  I know it
uses Public Key crypto in setting server credentials, but I don't know
if it uses DES or 3-DES in the secure RPC channels.  At one time it was
DES.  If it's still single DES, that sucks and is decidedly insecure.
SSL gives use 128K symetrical encryption.  That should be a minimum.

	If they claim that NIS+ will always be more secure than LDAP
over SSL (and I really DON'T know either way) then have them specify
the exact justifications for that claim.  Also have them justify
why we should accept a closed standard which we can not participate
in as a server.  Also have them justify why we should place ourselves
in a subordinant position, dependent on a closed source server for
our authentication services.  Also have them justify, why we should
accept degraded security in the authentication systems by being forced
to accept the old style DES hashes and 8 character limits on passwords.

	I just don't see where NIS+ can be justified as even being
qualified for the discussion.

	But then again...  Maybe times have changed and all these concerns
are just out of date.  If so, then were is my Linux based NIS+ server?
I would like to have a copy of that.  Then to, maybe the horse will learn
to sing (r.e. ancient Chinese fairy tale).

> Trever Adams

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

