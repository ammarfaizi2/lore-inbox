Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759451AbWLFBXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759451AbWLFBXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 20:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759454AbWLFBXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 20:23:45 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:47624 "EHLO
	pd5mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451AbWLFBXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 20:23:44 -0500
Date: Tue, 05 Dec 2006 19:21:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Why SCSI module needed for PCI-IDE ATA only disks ?
In-reply-to: <fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ed Sweetman <safemode2@comcast.net>
Message-id: <45761B2F.9060804@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.juE97gahpb4n2kNNH/Todtcvh3s@ifi.uio.no>
 <fa.IqtlZas3d+ZPuhF6S6N/ivdF8Wo@ifi.uio.no>
 <fa.HDRhmOhDQliejH7ijqJBWw9Jw0o@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> Jeff Garzik wrote:
>> Bernard Pidoux wrote:
>>> I am asking why need to compile the following modules while I do not
>>> have any SCSI device ?
>>
>> libata uses SCSI to provide a lot of infrastructure that it would 
>> otherwise have to recreate.  Also, using SCSI meant that it 
>> automatically worked in existing installers.
>>
>>     Jeff
>>
> This confusion could easily be remedied by explaining the requirement in 
> the Help output for libata drivers/section.  Also, making a dependency 
> in the menu (since there is one) or automatically selecting the required 
> scsi items when you select a libata driver would seem logical. As it is, 
> nothing is said of scsi requirements in menuconfig. Trying to boot a 
> machine without compiling the scsi drivers (something you're allowed to 
> do) results in a system that boots and initializes the ata busses but 
> can't communicate to any of the drives on them, (useless).

You can't select libata drivers without the SCSI core. However, you can 
select libata drivers without the SCSI disk (sd) or the SCSI CD (sr) 
drivers. However, that's a legitimate configuration as you may have only 
hard disks, only CD drives, etc. and there would be no need to build the 
other module. This isn't a major problem for most standard 
configurations as those drivers are needed to handle things like USB and 
FireWire flash drives, external HDs/optical drives, etc. anyway.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

