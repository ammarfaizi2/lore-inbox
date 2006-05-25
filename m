Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWEYUfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWEYUfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 16:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWEYUfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 16:35:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:40222 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030403AbWEYUfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 16:35:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ZPyRtbNFIHEcjX4DfOPumedFYQHjh6DABkddGRKxGsLnqRUADMlZ3+S2U3VaoK7MwufuY8BhlXeocMRwpUboTOyNHLQm0fOoKPP7TuUhD/pbIoOkqpnTllqziMGC7hP/EiiWNX9YnNy2FUlQk8qOEPjQVP2ho+wscwMbbDBuDSM=
Message-ID: <4476151A.4010404@gmail.com>
Date: Thu, 25 May 2006 22:35:15 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, stevel@mvista.com
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <20060525104147.GB3822@linux-mips.org>
In-Reply-To: <20060525104147.GB3822@linux-mips.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ralf Baechle napsal(a):
> On Wed, May 24, 2006 at 08:52:49PM -0400, Jeff Garzik wrote:
> 
>> Jiri Slaby wrote:
>>> gt96100eth use pci probing
>>>
>>> Convert pci_find_device to pci probing. Use dev_* macros for printing.
>>>
>>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> The GT-96100 is not a PCI device but a system controller.  The driver
> just checkes for the PCI ID to ensure it is not by accident being loaded
> on the wrong type of system.  Which of course is suspect.  If anything it
> should become a platform device.
Ooops. Ok, do you all agree to just remove pci_find_device() and add
pci_get_device() + pci_dev_put()? (And maybe next patch with dev_* macros).

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEdhUaMsxVwznUen4RAllLAJsEs5QVVkHojpljkShQRu28p53n6wCgsCkA
/SuFkkLFIsC7ToR6FeGGhAE=
=akyh
-----END PGP SIGNATURE-----
