Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287835AbSAIU74>; Wed, 9 Jan 2002 15:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSAIU7r>; Wed, 9 Jan 2002 15:59:47 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:21911
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287835AbSAIU7a>; Wed, 9 Jan 2002 15:59:30 -0500
Date: Wed, 9 Jan 2002 15:44:25 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Doug McNaught <doug@wireboard.com>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109154425.A28755@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Doug McNaught <doug@wireboard.com>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	felix-dietlibc@fefe.de
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <m3n0zn6ysr.fsf@varsoon.denali.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3n0zn6ysr.fsf@varsoon.denali.to>; from doug@wireboard.com on Wed, Jan 09, 2002 at 03:43:00PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught <doug@wireboard.com>:
> "Eric S. Raymond" <esr@snark.thyrsus.com> writes:
> 
> > greg k-h:
> > >What does everyone else need/want there?
> > 
> > dmidecode, so the init script can dump a DMI report in a known
> > location such as /var/run/dmi.  
> > 
> > I want this for autoconfiguration purposes.  If I can have it, I
> > won't need /proc/dmi.
> 
> Why can't this happen inside the regular startup scripts?  They know
> where to put such files; the kernel-level stuff doesn't--I can't think
> of any current situation where the kernel writes to an arbitrary file
> in the filesystem as it boots.  Sure, /var/run is in the FHS, but that
> doesn't mean every system will have it.
> 
> IMHO, since /var/run/dmi is not needed by any stage of the kernel
> boot, it should be created in the regular startup scripts (invoked by
> init(8)). 

You're right, I don't need this to be done at kernel level.  I do need it to
be done *everywhere*.  I'm not sure how else to guarantee this will happen. 
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The American Republic will endure, until politicians realize they can
bribe the people with their own money.
	-- Alexis de Tocqueville
