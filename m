Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265344AbSJXIEc>; Thu, 24 Oct 2002 04:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbSJXIEc>; Thu, 24 Oct 2002 04:04:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33296 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265344AbSJXIE3>; Thu, 24 Oct 2002 04:04:29 -0400
Date: Thu, 24 Oct 2002 09:10:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] more pcibios_* removals for 2.5.44
Message-ID: <20021024091037.A1346@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20021022183152.GG6471@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022183152.GG6471@kroah.com>; from greg@kroah.com on Tue, Oct 22, 2002 at 11:31:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 11:31:52AM -0700, Greg KH wrote:
> Attached is a patch for 2.5.44 that removes almost all of the remaining
> usages of pcibios_read_config* and pcibios_write_config* calls.  It also
> removes them from the pci.h, and drivers/pci/compat.c is gone.

You missed one in the pcmcia code.  I think this one will need a pseudo
pci-device created just to use the new interface - the right pci device
structure isn't anywhere in sight.

pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

