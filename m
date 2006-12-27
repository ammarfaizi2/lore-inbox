Return-Path: <linux-kernel-owner+w=401wt.eu-S1754750AbWL0WNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbWL0WNB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 17:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbWL0WNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 17:13:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35972 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750AbWL0WNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 17:13:00 -0500
Date: Wed, 27 Dec 2006 23:12:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Theodore Tso <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
Message-ID: <20061227221251.GF17785@petra.dvoda.cz>
References: <20061109224157.GH4324@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <20061227181510.GB17785@petra.dvoda.cz> <200612271939.48125.arnd@arndb.de> <20061227191824.GC17785@petra.dvoda.cz> <20061227204212.GA21393@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227204212.GA21393@thunk.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 03:42:13PM -0500, Theodore Tso wrote:
> On Wed, Dec 27, 2006 at 08:18:24PM +0100, Karel Zak wrote:
> >  Frankly, it wasn't always easy to use SeLinux in previous FC
> >  releases, but there is huge progress and I think it's much better in
> >  FC6.
> 
> I've never tried SELinux, but at one point there were all sorts of
> horror stories that if you enabled SELinux, the moment you installed
> any 3rd party software packages, whether it's Oracle or Websphere or
> some other commercial application program, the application would break
> because of all sorts of SELinux policy violations, and that it
> required an SELinux wizard to configure SELinux policy to enable a 3rd
> party application to actually work correctly.  Given that I tried
> enabling SELinux, witnessed things break spectacularly and with no
> hints about how to fix things, I've always had the attitude of "life
> is too short to enable SELinux", and so my limited experience is

 The level of security is always your choice. The real security is
 pretty expensive and you have to invest your time to make your system
 really safe. IMHO people who provides simple and cheap solutions are
 liars or marketing-agents or both.

 For example for my laptop is it true that "life is too short to
 enable SELinux", but it's probably not true for servers in the bank where
 I have money. (I hope so:-)

> consistent with all of the horror stories that I've heard.
>
> It sounds like SELinux has gotten better, according to your

 I'm really occasional selinux enduser only. So don't ask me for
 details.

> description.  Will handle arbitrary 3rd party software without running
> wild, or is it still the case that the moment you want anything other
> than software that was shipped with the distribution, it's "abandon
> all hope, all ye who enter here"?

 There is possible customization of the existing selinux policy. You
 can generate a new loadable policy module from system audit logs (see
 audit2allow util). In the other words -- your system in the permissive
 mode is monitoring your 3rd party software and from the logs you can
 generate new selinux rules. And when you switch system to the
 enforcing mode the application should be run as expected with your
 new rules.

    Karel 

-- 
 Karel Zak  <kzak@redhat.com>
