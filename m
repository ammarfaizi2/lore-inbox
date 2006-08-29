Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWH2OuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWH2OuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWH2OuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:50:05 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:43648 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965016AbWH2OuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:50:01 -0400
Date: Tue, 29 Aug 2006 10:49:54 -0400
To: Niklaus <niklaus@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: SDRAM or DDRAM in linux
Message-ID: <20060829144953.GM13641@csclub.uwaterloo.ca>
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com> <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com> <1156849696.6271.99.camel@localhost.localdomain> <85e0e3140608290555k31aadba5l8ecf814bae0a7484@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e0e3140608290555k31aadba5l8ecf814bae0a7484@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 06:55:20PM +0600, Niklaus wrote:
> Can you tell anything about it ? I have IBM x-series 206 server. Here
> is the dmidecode information. Is SDRAM or DDRAM installed on it. It
> would be great if you can tell me where to look.
> 
> Handle 0x0009, DMI type 6, 12 bytes
> Memory Module Information
> 	Socket Designation: DIMM3
> 	Bank Connections: 6 7
> 	Current Speed: Unknown
> 	Type: ECC DIMM SDRAM
> 	Installed Size: 256 MB (Single-bank Connection)
> 	Enabled Size: 256 MB (Single-bank Connection)
> 	Error Status: See Event Log

This looks like it sees a 256MB module in socket DIMM3

> Handle 0x001A, DMI type 17, 27 bytes
> Memory Device
> 	Array Handle: 0x0019
> 	Error Information Handle: No Error
> 	Total Width: Unknown
> 	Data Width: Unknown
> 	Size: No Module Installed
> 	Form Factor: DIMM
> 	Set: 1
> 	Locator: J5G2
> 	Bank Locator: DIMM 0
> 	Type: DDR
> 	Type Detail: Synchronous
> 	Speed: 133 MHz (7.5 ns)
> 	Manufacturer: Not Specified
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified

Socket DIMM0 says nothing is installed.

> Handle 0x001B, DMI type 17, 27 bytes
> Memory Device
> 	Array Handle: 0x0019
> 	Error Information Handle: No Error
> 	Total Width: Unknown
> 	Data Width: Unknown
> 	Size: No Module Installed
> 	Form Factor: DIMM
> 	Set: 1
> 	Locator: J5G3
> 	Bank Locator: DIMM 1
> 	Type: DDR
> 	Type Detail: Synchronous
> 	Speed: 133 MHz (7.5 ns)
> 	Manufacturer: Not Specified
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified

Socket DIMM1 says nothing is installed.

> Handle 0x001C, DMI type 17, 27 bytes
> Memory Device
> 	Array Handle: 0x0019
> 	Error Information Handle: No Error
> 	Total Width: Unknown
> 	Data Width: Unknown
> 	Size: No Module Installed
> 	Form Factor: DIMM
> 	Set: 1
> 	Locator: J5H1
> 	Bank Locator: DIMM 2
> 	Type: DDR
> 	Type Detail: Synchronous
> 	Speed: 133 MHz (7.5 ns)
> 	Manufacturer: Not Specified
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified

Socket DIMM2 says nothing is installed.

> Handle 0x001D, DMI type 17, 27 bytes
> Memory Device
> 	Array Handle: 0x0019
> 	Error Information Handle: No Error
> 	Total Width: 72 bits
> 	Data Width: 64 bits
> 	Size: 256 MB
> 	Form Factor: DIMM
> 	Set: 1
> 	Locator: J5H2
> 	Bank Locator: DIMM 3
> 	Type: DDR
> 	Type Detail: Synchronous
> 	Speed: 133 MHz (7.5 ns)
> 	Manufacturer: Not Specified
> 	Serial Number: Not Specified
> 	Asset Tag: Not Specified
> 	Part Number: Not Specified

This would appear to say that socket DIMM3 has a 256MB DIMM of type DDR
at 133MHZ, which would be 266MHz effective.  Odd given the x206 data
sheet I found only mentions 333 and 400MHz as supported.  Maybe the DMI
data is wrong, or maybe the memory in the system isn't right.

I think the only way to know for sure what type of ram a machine takes
is to read the manual, or maybe ask www.crucial.com (I have seen it have
information that was correct while an IBM manual for the machine was
wrong on the amount of ram a machine could take).

Crucial's information says the system has 4 DIMM slots for DDR memory,
and should use either PC2700 or PC3200 memory.

--
Len Sorensen
