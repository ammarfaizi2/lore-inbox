Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289646AbSAOUeK>; Tue, 15 Jan 2002 15:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290270AbSAOUeD>; Tue, 15 Jan 2002 15:34:03 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:27777
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289646AbSAOUds>; Tue, 15 Jan 2002 15:33:48 -0500
Date: Tue, 15 Jan 2002 15:18:04 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020115151804.A6308@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020115145324.A5772@thyrsus.com> <Pine.LNX.4.33.0201151514090.5892-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201151514090.5892-100000@xanadu.home>; from nico@cam.org on Tue, Jan 15, 2002 at 03:15:10PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org>:
> > Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> > 	* The `vitality' flag is gone from the language.  Instead, the 
> > 	  autoprober detects the type of your root filesystem and forces
> > 	  its symbol to Y.
> 
> What happens if you compile a kernel for another machine?  Or cross-compile?

In that case you can't use the autoconfigurator anyway.  You're going
to have to make sure by hand that the controller, bus type, and file
system code for your root device are hard-compiled in.  (This is at
least no worse off than you were under CML1.)

Rob Landley pointed out correctly that the vitality flag was not
actually solving this problem, and it was an ugly wart on the
language.  Instead, there's a symbol property "BOOTABLE" in the new
rulebase that is attached to IDE and SCSI hardware symbols that are
controllers for what could be boot devices.

One of the remaining limitations of the autoconfigurator is that it
only knows how to detect IDE and SCSI boot devices.  I want to be able
to make it nail NFS and USB storage being used as root, but it's not
there yet.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The American Republic will endure, until politicians realize they can
bribe the people with their own money.
	-- Alexis de Tocqueville
