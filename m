Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288117AbSBGQOe>; Thu, 7 Feb 2002 11:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288158AbSBGQOZ>; Thu, 7 Feb 2002 11:14:25 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:50698 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288117AbSBGQON>;
	Thu, 7 Feb 2002 11:14:13 -0500
Date: Thu, 7 Feb 2002 08:11:25 -0800
From: Greg KH <greg@kroah.com>
To: Ed Vance <EdV@macrolink.com>
Cc: "'Russell King'" <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: what serial driver restructure is planned?
Message-ID: <20020207161125.GP14504@kroah.com>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A768A@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A768A@EXCHANGE>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 10 Jan 2002 01:35:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 10:32:11AM -0800, Ed Vance wrote:
> I have a CompactPCI hot swap serial mux card that I need to support
> with hot swap functionality on Linux.  Has anybody already worked on
> issues like locking port names to physical slots, etc.?  Any basic
> advice?

There is some CompactPCI hot swap controller code that was written by
MontaVista, but isn't in the main kernel tree right now.  I was talking
with the author of it to move their code into the existing pci hotplug
structure that is in the kernel, but haven't heard back from them for a
while.

However, I don't think anyone has looked at device naming based on PCI
physical slots yet.  I know some attempts have been done for physical
location in the USB tree, so some of that old code might be helpful.
The hardest thing you will probably have is getting the physical slot
name from your pci driver.

Hope this helps,

greg k-h
