Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWA0QoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWA0QoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWA0QoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:44:19 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:51216 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750736AbWA0QoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:44:19 -0500
Message-ID: <43DA4DDA.7070509@superbug.co.uk>
Date: Fri, 27 Jan 2006 16:44:10 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: no To-header on input 
	<"unlisted-recipients:; "@pop3.mail.demon.net>,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz> <43DA2E79.nailFM911AZXH@burner>
In-Reply-To: <43DA2E79.nailFM911AZXH@burner>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> This are the three most important Linux kernel bugs:
>
> -	ide-scsi does not do DMA if the DMAsize is not a multiple of 512
> 	A person who knows internal Linux structures shoule be able
> 	to fix this (and allow any multiple of 4) in less than one hour.
> 	If we sum up the time spend on this discussoion, I really cannot
> 	understand why this has not been fixed earlier.
>
> -	/dev/hd* artificially prevents the ioctls SCSI_IOCTL_GET_IDLUN
> 	SCSI_IOCTL_GET_BUS_NUMBER from returning useful values.
> 	As long as this bug is present, there is no way to see SG_IO 
> 	via /dev/hd* as integral part of the Linux SCSI transport concept.
>
> -	If sending SCSI sia ATAPI, Linux under certain unknown conditions
> 	bastardizes the content of SCSI commands. A possible reason may be
> 	that it sends random data in the remainder between the actual 
> 	SCSI cdb size and the ATAPI SCSI cdb size.
>
> 	ATAPI drives that verify SCSI cdb's for correctness fail in this
> 	case.
>
> Jörg
>   
Would you be able to add the appropriate kernel bugzilla numbers?

I think it might also be useful to make a list of all the SCSI commands 
that cdrecord uses. Including all the vendor specific ones. One could 
then verify that the Linux kernel is passing them onto the device correctly.

James


