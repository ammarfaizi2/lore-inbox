Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSAPTF4>; Wed, 16 Jan 2002 14:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287163AbSAPTFr>; Wed, 16 Jan 2002 14:05:47 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:13585 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S287158AbSAPTFd>; Wed, 16 Jan 2002 14:05:33 -0500
Date: Wed, 16 Jan 2002 20:05:31 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020116200531.D18039@devcon.net>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200201151653.g0FGrlG12428@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Tue, Jan 15, 2002 at 09:53:47AM -0700
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 09:53:47AM -0700, Richard Gooch wrote:
> 
> Having to set the permissions like this on each boot seems a bit
> painful. Why not have permissions persistence like devfs has?

At least for the moment I don't think this is necessary.

Keep in mind that accessfs with the current ressource coverage
contains only entries which are static after initialization (except
for user-initiated permission changes of course), not like devfs where
entries are appearing, disappearing and reappearing all the time when
modules are loaded/unloaded etc. So a small shell script which sets
permissions once after boot should suffice in all cases (one could
also write a script which saves permissions on shutdown, to
automatically preserve changes made by the admin). 

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
