Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289025AbSAIVEr>; Wed, 9 Jan 2002 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSAIVEe>; Wed, 9 Jan 2002 16:04:34 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:23959
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289027AbSAIVCo>; Wed, 9 Jan 2002 16:02:44 -0500
Date: Wed, 9 Jan 2002 15:47:42 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109154742.B28755@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Patrick Mochel <mochel@osdl.org>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	felix-dietlibc@fefe.de
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <Pine.LNX.4.33.0201091247510.865-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201091247510.865-100000@segfault.osdlab.org>; from mochel@osdl.org on Wed, Jan 09, 2002 at 12:55:29PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org>:
> 
> On Wed, 9 Jan 2002, Eric S. Raymond wrote:
> 
> > greg k-h:
> > >What does everyone else need/want there?
> >
> > dmidecode, so the init script can dump a DMI report in a known
> > location such as /var/run/dmi.
> 
> Why do you need that during that stage of the boot process? The DMI tables
> won't go away.

I know.  My proposal to put dmidecode in initramfs is an alternative to
/proc/dmi, one which won't involve having dmidecode run in kernelspace.

The underlying problem is that dmidecode needs access to kmem, and I can't
assume that the person running my configurator will be root.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The whole of the Bill [of Rights] is a declaration of the right of the
people at large or considered as individuals...  It establishes some
rights of the individual as unalienable and which consequently, no
majority has a right to deprive them of.
         -- Albert Gallatin, Oct 7 1789
