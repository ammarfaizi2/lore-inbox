Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933606AbWLDFtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933606AbWLDFtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933640AbWLDFtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:49:16 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:49570 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S933606AbWLDFtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:49:16 -0500
Date: Sun, 03 Dec 2006 23:48:06 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata update?
In-reply-to: <fa.XmfqucrDh74GPgjK0cbwAsEAJfU@ifi.uio.no>
To: Erik@echohome.org
Cc: linux-kernel@vger.kernel.org
Message-id: <4573B696.2050808@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.uC+Bz5N+xQjpMrtHjbAs51RWHaE@ifi.uio.no>
 <fa.XmfqucrDh74GPgjK0cbwAsEAJfU@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Ohrnberger wrote:
> Not to sound too dense or anything, but is there a HOWTO for this kernel to
> enable the libata code?  
> 
> I've read through the Documentation/kernel-parameters.txt file, and seems
> like all I have to do is include libata.atapi_enabled=1 combined_mode=libata
> on the grub.conf line to enable it, but when I boot that kernel with that
> option, I get an error message: 'Block device /dev/sda1 is not a valid root
> device' and a 'boot() ::' prompt.

You shouldn't need atapi_enabled=1 anymore, and combined_mode only 
applies if you're using an Intel controller with that 
combined/legacy/AHCI selection braindamage. Did you select the right 
driver options in the kernel configuration? You'll either have to 
compile the driver(s) into the kernel or potentially do some 
distro-specific magic to ensure the modules get loaded in the initrd.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

